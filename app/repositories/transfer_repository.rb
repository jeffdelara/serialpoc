class TransferRepository
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def create_transfer
    transfer = Transfer.new(params)
    transfer.save && transfer.update(message_id: transfer.message_id)
    transfer
  end

  def save
    create_transfer
  rescue PG::UniqueViolation, ActiveRecord::RecordNotUnique => e
    # Edge case, when a unique violation is triggered while reset is incoming,
    # find the latest sequence and continue from there
    ActiveRecord::Base.transaction do
      results = Transfer.connection.execute("
        SELECT MAX(message_suffix_id) AS max_message_suffix_id
        FROM transfers
        WHERE message_date = CURRENT_DATE
      ")

      to = results.first['max_message_suffix_id']

      TransferRepository.reset_count(to: to + 1)
    end

    create_transfer
  end

  def self.sample(n = 100)
    transfer_ids = []
    
    n.times do
      transfer = new(amount: 1000).save
      transfer_ids << transfer.message_id
    end

    transfer_ids
  end

  # Run at midnight
  def self.reset_count(to: 1)
    ActiveRecord::Base.transaction do
      # Lock table so writes are not possible
      Transfer.connection.execute("LOCK TABLE transfers IN EXCLUSIVE MODE")
      # Reset transfers_message_id
      Transfer.connection.execute("ALTER SEQUENCE transfers_message_suffix_id_seq RESTART WITH #{to}")
      # sleep(10)
    end
  end
end

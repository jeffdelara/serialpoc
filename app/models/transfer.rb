class Transfer < ApplicationRecord
  SUFFIX_SIZE = 15
  BIC = 'BPIYPHM2XXXB'

  def message_id
    [
      message_date.strftime('%Y%m%d'),
      BIC,
      message_suffix_id.to_s.rjust(SUFFIX_SIZE, '0')
    ].join
  end
end

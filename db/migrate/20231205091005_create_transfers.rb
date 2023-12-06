class CreateTransfers < ActiveRecord::Migration[7.1]
  def change
    create_table :transfers do |t|
      t.integer :amount
      t.date :message_date, default: Date.current
      t.serial :message_suffix_id, null: false
      t.string :message_id

      t.timestamps
    end

    add_index :transfers, [:message_date, :message_suffix_id], unique: true
    add_index :transfers, [:message_id], unique: true
  end
end

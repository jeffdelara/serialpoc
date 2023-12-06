# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_05_091005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transfers", force: :cascade do |t|
    t.integer "amount"
    t.date "message_date", default: "2023-12-06"
    t.serial "message_suffix_id", null: false
    t.string "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_date", "message_suffix_id"], name: "index_transfers_on_message_date_and_message_suffix_id", unique: true
    t.index ["message_id"], name: "index_transfers_on_message_id", unique: true
  end

end

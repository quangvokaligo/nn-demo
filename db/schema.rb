# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_23_131235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "purchase_eraser_transactions", force: :cascade do |t|
    t.string "_id", null: false
    t.bigint "user_id", null: false
    t.integer "product_type", null: false
    t.integer "status", default: 0, null: false
    t.decimal "amount", null: false
    t.string "currency", null: false
    t.string "category_code"
    t.integer "points", null: false
    t.string "passed_checks", null: false, array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["_id"], name: "index_purchase_eraser_transactions_on__id"
    t.index ["status"], name: "index_purchase_eraser_transactions_on_status"
    t.index ["user_id"], name: "index_purchase_eraser_transactions_on_user_id"
  end

  create_table "webhooks", force: :cascade do |t|
    t.jsonb "payload", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

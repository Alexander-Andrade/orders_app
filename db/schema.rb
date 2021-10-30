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

ActiveRecord::Schema.define(version: 2021_10_30_153342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_line_items", force: :cascade do |t|
    t.bigint "booking_order_id", null: false
    t.decimal "quantity", precision: 16, scale: 2, null: false
    t.decimal "amount", precision: 16, scale: 2, null: false
    t.decimal "subtotal", precision: 16, scale: 2, null: false
    t.decimal "tax", precision: 16, scale: 2, null: false
    t.decimal "total", precision: 16, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_order_id"], name: "index_booking_line_items_on_booking_order_id"
  end

  create_table "booking_orders", force: :cascade do |t|
    t.decimal "subtotal", precision: 16, scale: 2, null: false
    t.decimal "tax", precision: 16, scale: 2, null: false
    t.decimal "total", precision: 16, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "booking_line_items", "booking_orders"
end
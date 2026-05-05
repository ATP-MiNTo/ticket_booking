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

ActiveRecord::Schema[8.1].define(version: 2026_05_01_200113) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string "check_in_code", default: "", null: false
    t.datetime "checked_in_at"
    t.datetime "created_at", null: false
    t.string "email"
    t.bigint "event_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["check_in_code"], name: "index_bookings_on_check_in_code", unique: true
    t.index ["event_id"], name: "index_bookings_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "date"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount_cents"
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.string "currency"
    t.string "provider"
    t.string "provider_ref"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
  end

  add_foreign_key "bookings", "events"
  add_foreign_key "payments", "bookings"
end

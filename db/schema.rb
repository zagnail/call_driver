# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170830114143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "directions", force: :cascade do |t|
    t.integer  "distance",       null: false
    t.integer  "duration",       null: false
    t.string   "end_address",    null: false
    t.string   "start_address",  null: false
    t.json     "end_location"
    t.json     "start_location"
    t.datetime "start_date",     null: false
    t.integer  "cost",           null: false
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id"], name: "index_directions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",           null: false
    t.string   "lastname",            null: false
    t.string   "email_address",       null: false
    t.string   "mobile_phone_number", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true, using: :btree
    t.index ["mobile_phone_number"], name: "index_users_on_mobile_phone_number", unique: true, using: :btree
  end

end

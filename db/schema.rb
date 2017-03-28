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

ActiveRecord::Schema.define(version: 20170328160710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_relations", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "attended_event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["attended_event_id"], name: "index_attendance_relations_on_attended_event_id", using: :btree
    t.index ["attendee_id", "attended_event_id"], name: "index_attendance_relations_on_attendee_id_and_attended_event_id", unique: true, using: :btree
    t.index ["attendee_id"], name: "index_attendance_relations_on_attendee_id", using: :btree
  end

  create_table "event_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "creator_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "picture"
    t.integer  "attendee_count",    default: 0
    t.date     "start_date"
    t.integer  "event_category_id"
    t.index ["creator_id", "created_at"], name: "index_events_on_creator_id_and_created_at", using: :btree
    t.index ["creator_id"], name: "index_events_on_creator_id", using: :btree
    t.index ["event_category_id"], name: "index_events_on_event_category_id", using: :btree
  end

  create_table "user_providers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_providers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "full_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "events", "event_categories"
  add_foreign_key "events", "users", column: "creator_id"
end

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

ActiveRecord::Schema.define(version: 2020_03_12_154431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "analytics", force: :cascade do |t|
    t.integer "word_count"
    t.string "emoji"
    t.string "location"
    t.string "created_day"
    t.string "created_time"
    t.string "weather"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "temperature"
    t.bigint "entry_id"
    t.integer "time_spent"
    t.index ["entry_id"], name: "index_analytics_on_entry_id"
  end

  create_table "emotions", force: :cascade do |t|
    t.string "emotion"
    t.integer "level"
    t.bigint "analytic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytic_id"], name: "index_emotions_on_analytic_id"
  end

  create_table "entries", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "emoji"
    t.datetime "start_entry"
    t.date "created_at_day"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "entry_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "entry_id"
    t.bigint "tag_id"
    t.index ["entry_id"], name: "index_entry_tags_on_entry_id"
    t.index ["tag_id"], name: "index_entry_tags_on_tag_id"
  end

  create_table "name_frequencies", force: :cascade do |t|
    t.string "name"
    t.bigint "analytic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytic_id"], name: "index_name_frequencies_on_analytic_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "gender"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "notifications"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "word_frequencies", force: :cascade do |t|
    t.string "word"
    t.integer "frequency"
    t.bigint "analytic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytic_id"], name: "index_word_frequencies_on_analytic_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "analytics", "entries"
  add_foreign_key "emotions", "analytics"
  add_foreign_key "entries", "users"
  add_foreign_key "entry_tags", "entries"
  add_foreign_key "entry_tags", "tags"
  add_foreign_key "name_frequencies", "analytics"
  add_foreign_key "reminders", "users"
  add_foreign_key "word_frequencies", "analytics"
end

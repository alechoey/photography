# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140321073038) do

  create_table "photo_set_memberships", id: false, force: true do |t|
    t.integer  "photo_id"
    t.integer  "photo_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_set_memberships", ["photo_set_id"], name: "index_photo_set_memberships_on_photo_set_id"

  create_table "photo_sets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "collection_id"
    t.boolean  "cover_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "portfolio_photo",    default: false
  end

  add_index "photos", ["cover_photo"], name: "index_photos_on_cover_photo"
  add_index "photos", ["portfolio_photo"], name: "index_photos_on_portfolio_photo"

  create_table "posts", force: true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "body_before_break"
    t.text     "body_after_break"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",            default: false
  end

  add_index "posts", ["public"], name: "index_posts_on_public"
  add_index "posts", ["slug"], name: "index_posts_on_slug"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

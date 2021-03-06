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

ActiveRecord::Schema.define(version: 20131228120635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: true do |t|
    t.string "name"
    t.string "programs", default: [], array: true
    t.string "code"
  end

  add_index "courses", ["code"], name: "index_courses_on_code", unique: true, using: :btree

  create_table "courses_items", id: false, force: true do |t|
    t.integer "course_id", null: false
    t.integer "item_id",   null: false
  end

  add_index "courses_items", ["item_id", "course_id"], name: "index_courses_items_on_item_id_and_course_id", unique: true, using: :btree

  create_table "items", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "isbn"
    t.string   "tags",       default: [], array: true
    t.string   "authors",    default: [], array: true
  end

  add_index "items", ["isbn"], name: "index_items_on_isbn", unique: true, using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "price"
    t.integer  "quality",    limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "edition"
    t.boolean  "archived",             default: false
  end

  add_index "orders", ["item_id"], name: "index_orders_on_item_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

end

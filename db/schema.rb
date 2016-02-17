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

ActiveRecord::Schema.define(version: 20160217230527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.text "title"
  end

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.integer  "website_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "links", ["website_id"], name: "index_links_on_website_id", using: :btree

  create_table "proccesseds", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.text    "liked"
    t.integer "shown_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.text "gender"
  end

  create_table "webpages", force: :cascade do |t|
    t.integer  "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  add_index "webpages", ["link_id"], name: "index_webpages_on_link_id", using: :btree

  create_table "websites", force: :cascade do |t|
    t.string   "url"
    t.integer  "depth_level"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "webpage_id"
  end

  add_index "websites", ["webpage_id"], name: "index_websites_on_webpage_id", using: :btree

  add_foreign_key "links", "websites"
  add_foreign_key "webpages", "links"
  add_foreign_key "websites", "webpages"
end

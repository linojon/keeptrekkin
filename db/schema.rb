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

ActiveRecord::Schema.define(version: 20140808170802) do

  create_table "attachinary_files", force: true do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hiker_id"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent"
  add_index "attachinary_files", ["hiker_id"], name: "index_attachinary_files_on_hiker_id"

  create_table "hiker_trips", id: false, force: true do |t|
    t.integer "hiker_id", null: false
    t.integer "trip_id",  null: false
  end

  add_index "hiker_trips", ["hiker_id", "trip_id"], name: "index_hiker_trips_on_hiker_id_and_trip_id", unique: true

  create_table "hikers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "profile_image"
    t.string   "location"
    t.boolean  "disable_notifications"
    t.integer  "profile_image_id"
  end

  create_table "links", force: true do |t|
    t.string   "site_name"
    t.string   "url"
    t.string   "rating"
    t.integer  "mountain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["mountain_id"], name: "index_links_on_mountain_id"

  create_table "mountain_trips", id: false, force: true do |t|
    t.integer "mountain_id", null: false
    t.integer "trip_id",     null: false
  end

  add_index "mountain_trips", ["mountain_id", "trip_id"], name: "index_mountain_trips_on_mountain_id_and_trip_id", unique: true

  create_table "mountains", force: true do |t|
    t.string   "name"
    t.integer  "elevation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.string   "location"
    t.string   "state"
    t.float    "lat"
    t.float    "lng"
    t.text     "description"
    t.text     "hikes"
  end

  create_table "trips", force: true do |t|
    t.date     "date"
    t.string   "distance"
    t.string   "duration"
    t.text     "journal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "title_image_id"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hiker_id"
    t.string   "profile_url"
    t.string   "image_url"
  end

end

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

ActiveRecord::Schema.define(version: 20140702060658) do

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
    t.string   "profile_image_url"
    t.string   "profile_chip_url"
  end

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
  end

  create_table "pictures", force: true do |t|
    t.integer "trip_id"
    t.integer "hiker_id"
    t.string  "image"
    t.string  "caption"
  end

  add_index "pictures", ["hiker_id"], name: "index_pictures_on_hiker_id"
  add_index "pictures", ["trip_id"], name: "index_pictures_on_trip_id"

  create_table "trips", force: true do |t|
    t.date     "date"
    t.string   "distance"
    t.string   "duration"
    t.text     "journal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
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
  end

end

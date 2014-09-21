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

ActiveRecord::Schema.define(version: 20140921212936) do

  create_table "stations", force: true do |t|
    t.string   "name"
    t.string   "query_name"
    t.float    "lat"
    t.float    "long"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stations", ["name"], name: "index_stations_on_name"

  create_table "stops", force: true do |t|
    t.datetime "scheduled_time"
    t.string   "line_name"
    t.string   "line_direction"
    t.string   "line_identifier"
    t.string   "line_type"
    t.string   "key"
    t.integer  "station_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stops", ["line_direction"], name: "index_stops_on_line_direction"
  add_index "stops", ["line_name"], name: "index_stops_on_line_name"
  add_index "stops", ["scheduled_time"], name: "index_stops_on_scheduled_time"
  add_index "stops", ["station_id"], name: "index_stops_on_station_id"

end

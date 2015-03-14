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

ActiveRecord::Schema.define(version: 20150314230425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "photo_albums", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_albums", ["category_id", "created_at"], name: "index_photo_albums_on_category_id_and_created_at", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "photo_album_id"
    t.string   "title"
    t.string   "description"
    t.string   "photo_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["photo_album_id", "created_at"], name: "index_photos_on_photo_album_id_and_created_at", using: :btree

end

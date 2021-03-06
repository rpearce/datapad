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

ActiveRecord::Schema.define(version: 20151016155423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliations", force: :cascade do |t|
    t.string   "name",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "display_value", null: false
    t.string   "search_text"
  end

  create_table "character_affiliations", force: :cascade do |t|
    t.integer  "character_id",   null: false
    t.integer  "affiliation_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "character_affiliations", ["character_id", "affiliation_id"], name: "index_character_affiliations_on_character_id_and_affiliation_id", unique: true, using: :btree

  create_table "characters", force: :cascade do |t|
    t.string   "image"
    t.string   "name"
    t.string   "homeworld"
    t.string   "species"
    t.text     "summary"
    t.string   "external_uri"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end

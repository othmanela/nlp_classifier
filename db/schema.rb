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

ActiveRecord::Schema.define(version: 20150518214948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.integer "count"
    t.integer "complement_count"
    t.string  "translated_name"
  end

  create_table "complements", force: :cascade do |t|
    t.integer "category_id"
    t.string  "word"
    t.integer "count"
    t.float   "tfidf"
    t.float   "weight"
    t.float   "normalized_weight"
    t.float   "mid_weight"
  end

  create_table "data", force: :cascade do |t|
    t.integer "category_id"
    t.string  "source_url"
    t.string  "title"
    t.text    "content"
  end

  create_table "results", force: :cascade do |t|
    t.integer "category_id"
    t.string  "word"
    t.integer "count"
    t.float   "tfidf"
    t.float   "weight"
    t.float   "normalized_weight"
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.float  "df"
    t.float  "idf"
  end

end

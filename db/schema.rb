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

ActiveRecord::Schema.define(version: 20211204230411) do

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.string   "author"
    t.string   "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string   "title"
    t.string   "status"
    t.string   "buyer_id"
    t.string   "buyer_name"
    t.string   "seller_id"
    t.string   "seller_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
    t.integer  "post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "author"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author_id"
    t.integer  "onshelf",    default: 1
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.string "uid"
    t.string "provider"
    t.string "phone"
    t.string "address"
    t.string "description"
  end

end

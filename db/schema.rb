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

ActiveRecord::Schema.define(version: 20150201115527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",                  null: false
    t.integer  "nip",         limit: 8
    t.string   "address"
    t.string   "city"
    t.integer  "post_code"
    t.text     "description"
    t.text     "contact"
    t.integer  "company_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "companies", ["company_id"], name: "index_companies_on_company_id", using: :btree

  create_table "offers", force: :cascade do |t|
    t.integer  "company_id", null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "offers", ["company_id"], name: "index_offers_on_company_id", using: :btree

  create_table "product_offers", force: :cascade do |t|
    t.integer  "offer_id",   null: false
    t.integer  "product_id", null: false
    t.string   "type",       null: false
    t.decimal  "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_offers", ["offer_id"], name: "index_product_offers_on_offer_id", using: :btree
  add_index "product_offers", ["product_id"], name: "index_product_offers_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                                                   null: false
    t.string   "unit",                                                   null: false
    t.integer  "quantity_container",                         default: 1
    t.decimal  "volume_container",   precision: 8, scale: 2
    t.decimal  "price",              precision: 8, scale: 2
    t.integer  "vat",                                                    null: false
    t.integer  "category_id"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  add_foreign_key "companies", "companies"
  add_foreign_key "offers", "companies"
  add_foreign_key "product_offers", "offers"
  add_foreign_key "product_offers", "products"
  add_foreign_key "products", "categories"
end

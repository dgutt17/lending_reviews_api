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

ActiveRecord::Schema.define(version: 2019_08_17_210800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
  end

  create_table "business_urls", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "total_rating"
    t.integer "interest_rate_rating"
    t.integer "fee_closing_cost_rating"
    t.integer "customer_service_rating"
    t.integer "responsiveness_rating"
    t.boolean "closed_with_lender"
    t.boolean "would_recommend_lender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "business_url_id"
    t.string "review_date"
    t.integer "author_id"
    t.index ["author_id"], name: "index_reviews_on_author_id"
    t.index ["business_url_id"], name: "index_reviews_on_business_url_id"
  end

end

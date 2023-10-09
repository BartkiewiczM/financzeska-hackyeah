# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_06_150317) do
  create_table "datasets", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.string "slug"
    t.integer "downloads_count"
    t.text "notes"
    t.text "license_condition_custom_description"
    t.string "archived_resources_files_url"
    t.string "url"
    t.string "title"
    t.string "image_url"
    t.datetime "modified"
    t.datetime "created"
    t.boolean "followed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dataset_id"
    t.index ["institution_id"], name: "index_datasets_on_institution_id"
  end

  create_table "faqs", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "weaviate_id"
    t.index ["weaviate_id"], name: "index_faqs_on_weaviate_id", unique: true
  end

  create_table "institutions", charset: "utf8mb3", force: :cascade do |t|
    t.string "slug"
    t.string "tel"
    t.text "notes"
    t.string "postal_code"
    t.string "abbreviation"
    t.string "email"
    t.string "regon"
    t.string "flat_number"
    t.string "city"
    t.string "institution_type"
    t.string "title"
    t.string "image_url"
    t.string "street"
    t.string "street_type"
    t.text "description"
    t.string "website"
    t.string "street_number"
    t.datetime "modified"
    t.datetime "created"
    t.string "epuap"
    t.string "fax"
    t.boolean "followed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.boolean "from_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "datasets", "institutions"
end

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

ActiveRecord::Schema[7.2].define(version: 2024_08_25_054230) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "wine_acidity", ["low", "medium", "high"]
  create_enum "wine_body", ["very_light", "light", "medium", "full", "very_full"]
  create_enum "wine_kind", ["red", "sparkling", "dessert_port", "dessert", "rose", "white"]

  create_table "wines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "dataset_id"
    t.string "name"
    t.decimal "alcohol_by_volume", precision: 3, scale: 1
    t.string "country_code"
    t.integer "vintages", default: [], array: true
    t.enum "kind", default: "red", null: false, enum_type: "wine_kind"
    t.enum "body", default: "very_light", null: false, enum_type: "wine_body"
    t.enum "acidity", default: "low", null: false, enum_type: "wine_acidity"
    t.uuid "elaborate_id", null: false
    t.uuid "region_id", null: false
    t.uuid "winery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["elaborate_id"], name: "index_wines_on_elaborate_id"
    t.index ["region_id"], name: "index_wines_on_region_id"
    t.index ["winery_id"], name: "index_wines_on_winery_id"
  end

  create_table "wines_elaborates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wines_grapes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wines_harmonizes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wines_regions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "dataset_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wines_wineries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "dataset_id"
    t.string "name"
    t.string "website_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wines_wines_grapes", id: false, force: :cascade do |t|
    t.uuid "wine_id", null: false
    t.uuid "wines_grape_id", null: false
    t.index ["wine_id"], name: "index_wines_wines_grapes_on_wine_id"
    t.index ["wines_grape_id"], name: "index_wines_wines_grapes_on_wines_grape_id"
  end

  create_table "wines_wines_harmonizes", id: false, force: :cascade do |t|
    t.uuid "wine_id", null: false
    t.uuid "wines_harmonize_id", null: false
    t.index ["wine_id"], name: "index_wines_wines_harmonizes_on_wine_id"
    t.index ["wines_harmonize_id"], name: "index_wines_wines_harmonizes_on_wines_harmonize_id"
  end

  add_foreign_key "wines", "wines_elaborates", column: "elaborate_id"
  add_foreign_key "wines", "wines_regions", column: "region_id"
  add_foreign_key "wines", "wines_wineries", column: "winery_id"
end

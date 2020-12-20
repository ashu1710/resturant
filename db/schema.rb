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

ActiveRecord::Schema.define(version: 2020_06_08_163355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.text "street_1"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city_name"
    t.string "area_name"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "mobile"
    t.boolean "is_admin", default: false
    t.bigint "city_id"
    t.bigint "area_id"
    t.text "address"
    t.string "seq_no"
    t.index ["area_id"], name: "index_admins_on_area_id"
    t.index ["city_id"], name: "index_admins_on_city_id"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_areas_on_city_id"
  end

  create_table "auth_tokens", force: :cascade do |t|
    t.string "token"
    t.string "user_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_type", "user_id"], name: "index_auth_tokens_on_user_type_and_user_id"
  end

  create_table "banners", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_link_redirect"
  end

  create_table "bookings", force: :cascade do |t|
    t.date "booking_date"
    t.time "time_from"
    t.time "time_to"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_done", default: false
    t.boolean "is_confirmed"
    t.bigint "user_id"
    t.index ["product_id"], name: "index_bookings_on_product_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "qty"
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "color_id"
    t.bigint "size_id"
    t.index ["color_id"], name: "index_carts_on_color_id"
    t.index ["product_id"], name: "index_carts_on_product_id"
    t.index ["size_id"], name: "index_carts_on_size_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category_type"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "color_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "color_id"
  end

  create_table "devise_tokens", force: :cascade do |t|
    t.text "token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devise_tokens_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "msg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_confirmed", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.string "email"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "msg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.date "order_date"
    t.date "order_receive_date"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_confirmed"
    t.bigint "user_id"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.bigint "category_id"
    t.bigint "sub_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "admin_id"
    t.boolean "is_first_product", default: false
    t.index ["admin_id"], name: "index_products_on_admin_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["sub_category_id"], name: "index_products_on_sub_category_id"
  end

  create_table "products_orders_sizes_colors", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "order_id"
    t.bigint "size_id"
    t.bigint "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "qty", default: 1
    t.bigint "user_id"
    t.index ["color_id"], name: "index_products_orders_sizes_colors_on_color_id"
    t.index ["order_id"], name: "index_products_orders_sizes_colors_on_order_id"
    t.index ["product_id"], name: "index_products_orders_sizes_colors_on_product_id"
    t.index ["size_id"], name: "index_products_orders_sizes_colors_on_size_id"
    t.index ["user_id"], name: "index_products_orders_sizes_colors_on_user_id"
  end

  create_table "products_sizes", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "size_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "size_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.integer "user_type"
    t.date "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "mobile"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "areas", "cities"
  add_foreign_key "bookings", "products"
  add_foreign_key "carts", "colors"
  add_foreign_key "carts", "products"
  add_foreign_key "carts", "sizes"
  add_foreign_key "carts", "users"
  add_foreign_key "devise_tokens", "users"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "sub_categories"
  add_foreign_key "products_orders_sizes_colors", "colors"
  add_foreign_key "products_orders_sizes_colors", "orders"
  add_foreign_key "products_orders_sizes_colors", "products"
  add_foreign_key "products_orders_sizes_colors", "sizes"
  add_foreign_key "products_orders_sizes_colors", "users"
  add_foreign_key "sub_categories", "categories"
end

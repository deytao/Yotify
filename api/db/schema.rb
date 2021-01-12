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

ActiveRecord::Schema.define(version: 2021_01_12_173724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.string "name"
    t.string "ticker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.string "contact_email"
    t.date "signup_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_customers_on_slug", unique: true
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.string "body", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.datetime "sent_at", null: false
    t.datetime "read_at"
    t.integer "message_id", null: false
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_notifications_on_customer_id"
    t.index ["message_id"], name: "index_notifications_on_message_id"
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "portfolios", force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.string "name", null: false
    t.integer "amount", null: false
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_twr_run_at"
    t.float "current_twr", default: 0.0
    t.index ["customer_id"], name: "index_portfolios_on_customer_id"
  end

  create_table "positions", force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.float "weight", default: 0.0, null: false
    t.bigint "company_id"
    t.bigint "portfolio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_positions_on_company_id"
    t.index ["portfolio_id"], name: "index_positions_on_portfolio_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "customer_id"
    t.index ["customer_id"], name: "index_users_on_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "customers"
  add_foreign_key "notifications", "messages"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "portfolios", "customers"
  add_foreign_key "positions", "companies"
  add_foreign_key "positions", "portfolios"
  add_foreign_key "users", "customers"
end

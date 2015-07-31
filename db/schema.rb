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

ActiveRecord::Schema.define(version: 20150731082018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academy_entries", force: :cascade do |t|
    t.string   "title",                              null: false
    t.string   "image",                              null: false
    t.string   "level",                              null: false
    t.string   "pdf_download",                       null: false
    t.text     "summary",                            null: false
    t.text     "mailchimp_form"
    t.string   "mailchimp_frequency"
    t.string   "slug"
    t.boolean  "display",             default: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",                             null: false
    t.string   "slug"
    t.text     "content",                           null: false
    t.text     "video"
    t.string   "infographic"
    t.date     "date"
    t.boolean  "display",           default: true
    t.text     "summary"
    t.integer  "team_member_id"
    t.string   "approach"
    t.string   "image"
    t.string   "guide"
    t.boolean  "academy_content",   default: false
    t.boolean  "news_content",      default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "duplicate_content", default: true
  end

  add_index "articles", ["team_member_id"], name: "index_articles_on_team_member_id", using: :btree

  create_table "chronicler_documents", force: :cascade do |t|
    t.string   "name"
    t.string   "document"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chronicler_images", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "manticore_administrators", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "role"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_send_at"
  end

  create_table "seo_entries", force: :cascade do |t|
    t.string   "nominal_url"
    t.string   "title"
    t.text     "meta_description"
    t.boolean  "in_sitemap",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", force: :cascade do |t|
    t.string   "name"
    t.text     "profile"
    t.string   "image"
    t.string   "tag_line"
    t.string   "google_plus"
    t.string   "twitter"
    t.boolean  "display",     default: true
    t.integer  "position"
    t.string   "job_title"
    t.boolean  "director",    default: false
    t.string   "sector"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "email"
  end

  create_table "willow_branches", force: :cascade do |t|
    t.string  "tree"
    t.string  "name"
    t.integer "position",              default: 0
    t.string  "ancestry"
    t.integer "ancestry_depth",        default: 0
    t.string  "positions_depth_cache"
    t.integer "leaf_id"
    t.string  "leaf_type"
    t.boolean "sturdy",                default: false
    t.boolean "can_have_children",     default: false
    t.boolean "primary",               default: false
    t.string  "access_key"
  end

  add_index "willow_branches", ["ancestry"], name: "index_willow_branches_on_ancestry", using: :btree

  create_table "willow_leaves", force: :cascade do |t|
    t.string "name"
    t.string "route"
    t.string "type"
  end

  add_foreign_key "articles", "team_members"
end

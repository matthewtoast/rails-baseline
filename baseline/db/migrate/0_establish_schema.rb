class EstablishSchema < ActiveRecord::Migration[6.0]
  def change
    enable_extension "pg_trgm"
    enable_extension "pgcrypto"
    enable_extension "plpgsql"
    enable_extension "uuid-ossp"

    create_table "api_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "token", null: false
      t.uuid "user_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end

    create_table "friendly_id_slugs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "slug", null: false
      t.uuid "sluggable_id", null: false
      t.string "sluggable_type", limit: 50
      t.string "scope"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
      t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
      t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
    end

    create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "name", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end

    create_table "taggings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "tag_id", null: false
      t.uuid "tagger_id", null: false
      t.uuid "taggable_id", null: false
      t.string "taggable_type", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "count", default: 1, null: false
      t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    end

    create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "name", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end

    create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "email", null: false
      t.uuid "role_id", null: false
      t.string "given_name", null: false
      t.string "family_name", null: false
      t.string "picture_url"
      t.string "slug"
      t.string "bio"
      t.string "location"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end

    create_table "friendships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "user_id", null: false
      t.uuid "friend_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end

    create_table "votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "voter_id", null: false
      t.string "votable_type", null: false
      t.uuid "votable_id", null: false
      t.string "kind", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end

    create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "commenter_id", null: false
      t.string "commentable_type", null: false
      t.uuid "commentable_id", null: false
      t.uuid "parent_id", null: false
      t.text "text"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end

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

ActiveRecord::Schema[8.0].define(version: 2025_02_28_014153) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "game_rooms", force: :cascade do |t|
    t.string "room_id", null: false
    t.string "topic", null: false
    t.integer "time_per_answer", null: false
    t.string "lobby_type", null: false
    t.string "accessibility", null: false
    t.text "letters_pressed", default: [], array: true
    t.integer "rounds_played", default: 0
    t.integer "player_turn", default: 0
    t.boolean "is_active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_players", default: 4
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "session_user_id", null: false
    t.bigint "game_room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_id"], name: "index_messages_on_game_room_id"
    t.index ["session_user_id"], name: "index_messages_on_session_user_id"
  end

  create_table "session_users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "games_won", default: 0
    t.text "letters_used", default: [], array: true
    t.boolean "is_turn", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_room_id"
    t.index ["game_room_id"], name: "index_session_users_on_game_room_id"
  end

  add_foreign_key "messages", "game_rooms"
  add_foreign_key "messages", "session_users"
  add_foreign_key "session_users", "game_rooms"
end

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

ActiveRecord::Schema.define(version: 20180911220337) do

  create_table "artists", id: :string, force: :cascade do |t|
    t.string  "name"
    t.integer "popularity"
    t.index ["id"], name: "sqlite_autoindex_artists_1", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "playlist_id"
    t.index ["playlist_id"], name: "index_follows_on_playlist_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "playlist_songs", force: :cascade do |t|
    t.integer "song_id"
    t.integer "playlist_id"
    t.index ["playlist_id"], name: "index_playlist_songs_on_playlist_id"
    t.index ["song_id"], name: "index_playlist_songs_on_song_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "plays", force: :cascade do |t|
    t.integer "user_id"
    t.integer "song_id"
    t.index ["song_id"], name: "index_plays_on_song_id"
    t.index ["user_id"], name: "index_plays_on_user_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string  "name"
    t.integer "popularity"
    t.float   "danceability"
    t.string  "artist_id"
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end

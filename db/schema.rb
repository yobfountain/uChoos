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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110628145841) do

  create_table "scenes", :force => true do |t|
    t.integer  "story_id"
    t.string   "name"
    t.text     "scene_text"
    t.integer  "order"
    t.string   "scene_audio"
    t.string   "scene_audio_duration"
    t.text     "choice_text"
    t.string   "choice_audio"
    t.string   "choice_audio_duration"
    t.integer  "option_one"
    t.integer  "option_two"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.integer  "user_id"
    t.string   "keyword"
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "mobile_number"
    t.string   "email"
    t.string   "name"
    t.boolean  "can_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_game"
    t.string   "last_scene"
  end

end

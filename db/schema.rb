# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090701100306) do

  create_table "comments", :force => true do |t|
    t.integer "page_id"
    t.string  "name"
    t.string  "email"
    t.text    "description"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "published_on"
    t.string   "image_credits"
    t.string   "image_taken_in"
    t.string   "music_credits"
    t.string   "music_file_name"
    t.string   "music_content_type"
    t.integer  "music_file_size"
    t.datetime "music_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "music_state"
  end

end

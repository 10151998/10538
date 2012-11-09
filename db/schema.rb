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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121205224719) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "challenge_messages", :force => true do |t|
    t.integer  "sender_team_id"
    t.integer  "receiver_team_id"
    t.integer  "user_id"
    t.datetime "datetime"
    t.string   "location",         :limit => 45
    t.integer  "is_read",                        :default => 0
    t.integer  "message_type"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "constants", :force => true do |t|
    t.string   "name",       :limit => 45
    t.string   "value",      :limit => 45
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "fun_locations", :force => true do |t|
    t.string   "name",       :limit => 45
    t.string   "address",    :limit => 100
    t.float    "longitude"
    t.float    "latitude"
    t.string   "gmaps",      :limit => 45
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "funs", :force => true do |t|
    t.string   "name",            :limit => 45
    t.integer  "game_id"
    t.datetime "datetime"
    t.integer  "fun_location_id"
    t.integer  "popularity",                    :default => 0
    t.integer  "school_id"
    t.integer  "is_available",                  :default => 1
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "imports", :force => true do |t|
    t.string   "datatype",         :limit => 45
    t.integer  "processed",                       :default => 0
    t.string   "csv_file_name",    :limit => 200
    t.string   "csv_content_type", :limit => 45
    t.integer  "csv_file_size"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "levels", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "mentor_messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "subject"
    t.string   "content"
    t.integer  "is_read",      :default => 0
    t.integer  "message_type"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "music_likes", :force => true do |t|
    t.integer  "music_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "musics", :force => true do |t|
    t.string   "name",       :limit => 45
    t.string   "artist",     :limit => 45
    t.integer  "popularity",               :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "pe_classes", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "datetime"
    t.integer  "school_id"
    t.integer  "teacher_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "pe_classmembers", :force => true do |t|
    t.integer  "pe_class_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "name",       :limit => 45
    t.string   "address",    :limit => 100
    t.string   "city",       :limit => 45
    t.string   "state",      :limit => 45
    t.integer  "zipcode"
    t.string   "telephone",  :limit => 45
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sport_levels", :force => true do |t|
    t.integer  "number"
    t.string   "name",       :limit => 45
    t.string   "guidence",   :limit => 1000
    t.integer  "sport_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "sports", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               :limit => 45
    t.string   "firstname",              :limit => 45
    t.string   "lastname",               :limit => 45
    t.string   "gender",                 :limit => 45
    t.integer  "school_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "teachers", ["email"], :name => "index_teachers_on_email", :unique => true
  add_index "teachers", ["reset_password_token"], :name => "index_teachers_on_reset_password_token", :unique => true

  create_table "team_challenges", :force => true do |t|
    t.integer  "sender_team_id"
    t.integer  "receiver_team_id"
    t.datetime "datetime"
    t.string   "location",         :limit => 45
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "team_points", :force => true do |t|
    t.integer  "team_id"
    t.integer  "point_of_week"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "teammembers", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name",           :limit => 45
    t.integer  "user_id"
    t.integer  "sport_id"
    t.integer  "sport_level_id"
    t.integer  "level_id"
    t.string   "is_available",                 :default => "1"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "trainers", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               :limit => 45
    t.string   "firstname",              :limit => 45
    t.string   "lastname",               :limit => 45
    t.string   "gender",                 :limit => 45
    t.integer  "sport_id"
    t.string   "icon_filename"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "trainers", ["email"], :name => "index_trainers_on_email", :unique => true
  add_index "trainers", ["reset_password_token"], :name => "index_trainers_on_reset_password_token", :unique => true

  create_table "uploads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_steps"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_funs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "fun_id"
    t.integer  "is_attend",  :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "user_game_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_points", :force => true do |t|
    t.integer  "user_id"
    t.integer  "point_event", :default => 0
    t.integer  "point_fun",   :default => 0
    t.integer  "point_music", :default => 0
    t.integer  "point_video", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "user_sport_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sport_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               :limit => 45
    t.string   "firstname",              :limit => 45
    t.string   "lastname",               :limit => 45
    t.string   "email_parent",           :limit => 45
    t.string   "gender",                 :limit => 45
    t.integer  "pe_class_id"
    t.integer  "active_code",                          :default => 0
    t.integer  "step",                                 :default => 0
    t.integer  "totalSteps",                           :default => 0
    t.string   "icon_filename"
    t.integer  "image_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "source_content_type"
    t.string   "source_file_name"
    t.integer  "source_file_size"
    t.integer  "sport_id"
    t.integer  "trainer_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end

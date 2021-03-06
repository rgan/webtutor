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

ActiveRecord::Schema.define(:version => 1) do

  create_table "questions", :force => true do |t|
    t.text     "content"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["topic_id"], :name => "fk_questions_topics"

  create_table "results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.float    "score"
    t.integer  "time_taken_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["topic_id"], :name => "fk_results_topic_id"
  add_index "results", ["user_id"], :name => "fk_results_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_users", ["role_id"], :name => "fk_roles_users_role_id"
  add_index "roles_users", ["user_id"], :name => "fk_roles_users_user_id"

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["parent_id"], :name => "fk_topics_topics"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password", :limit => 40
    t.string   "salt",               :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

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

ActiveRecord::Schema.define(version: 0) do

  create_table "performances", force: :cascade do |t|
    t.integer  "school",                           limit: 4
    t.string   "dbn",                              limit: 255
    t.decimal  "on_track_2013",                                precision: 3,  scale: 2
    t.decimal  "graduation_rate_2013",                         precision: 3,  scale: 2
    t.decimal  "college_rate_2013",                            precision: 3,  scale: 2
    t.decimal  "student_staisfaction_2013",                    precision: 2,  scale: 1
    t.decimal  "on_track_2012",                                precision: 3,  scale: 2
    t.decimal  "graduation_rate_2012",                         precision: 3,  scale: 2
    t.decimal  "college_rate_2012",                            precision: 3,  scale: 2
    t.decimal  "student_satisfaction_2012",                    precision: 10
    t.decimal  "on_track_sim_schools",                         precision: 2,  scale: 1
    t.decimal  "grad_rate_sim_schools",                        precision: 3,  scale: 2
    t.decimal  "college_rate_sim_schools",                     precision: 3,  scale: 2
    t.decimal  "student_satisfaction_sim_schools",             precision: 2,  scale: 1
    t.string   "quality_rating",                   limit: 255
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  add_index "performances", ["school"], name: "index_performances_on_school", using: :btree

end

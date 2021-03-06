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

ActiveRecord::Schema.define(version: 20150402190202) do

  create_table "after_school_programs", force: :cascade do |t|
    t.string   "program",         limit: 255
    t.string   "program_type",    limit: 255
    t.string   "site",            limit: 255
    t.string   "boro",            limit: 255
    t.string   "agency",          limit: 255
    t.string   "grade_age_level", limit: 255
    t.decimal  "latitude",                    precision: 16, scale: 14
    t.decimal  "longitude",                   precision: 16, scale: 14
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "performances", force: :cascade do |t|
    t.string   "dbn",                              limit: 255
    t.decimal  "on_track_2013",                                precision: 3, scale: 2
    t.decimal  "grad_rate_2013",                               precision: 3, scale: 2
    t.decimal  "college_rate_2013",                            precision: 3, scale: 2
    t.decimal  "student_satisfaction",                         precision: 2, scale: 1
    t.decimal  "on_track_2012",                                precision: 3, scale: 2
    t.decimal  "grad_rate_2012",                               precision: 3, scale: 2
    t.decimal  "college_rate_2012",                            precision: 3, scale: 2
    t.decimal  "student_satisfation_2012",                     precision: 3, scale: 2
    t.decimal  "on_track_sim_schools",                         precision: 3, scale: 2
    t.decimal  "grad_rate_sim_schools",                        precision: 3, scale: 2
    t.decimal  "college_rate_sim_schools",                     precision: 3, scale: 2
    t.decimal  "student_satisfaction_sim_schools",             precision: 2, scale: 1
    t.string   "quality_review",                   limit: 255
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  create_table "raw_safety_reports", force: :cascade do |t|
    t.string   "building",            limit: 255
    t.string   "dbn",                 limit: 255
    t.integer  "major_crimes",        limit: 4
    t.integer  "other_crimes",        limit: 4
    t.integer  "incidents",           limit: 4
    t.integer  "property_crimes",     limit: 4
    t.integer  "violent_crimes",      limit: 4
    t.integer  "number_schools",      limit: 4
    t.string   "group_size",          limit: 255
    t.decimal  "avg_major_crimes",                precision: 4, scale: 2
    t.decimal  "avg_other_crimes",                precision: 4, scale: 2
    t.decimal  "avg_incidents",                   precision: 4, scale: 2
    t.decimal  "avg_property_crimes",             precision: 4, scale: 2
    t.decimal  "avg_violent_crimes",              precision: 4, scale: 2
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "safety_reports", force: :cascade do |t|
    t.string   "building",            limit: 255
    t.string   "dbn",                 limit: 255
    t.integer  "major_crimes",        limit: 4
    t.integer  "other_crimes",        limit: 4
    t.integer  "incidents",           limit: 4
    t.integer  "property_crimes",     limit: 4
    t.integer  "violent_crimes",      limit: 4
    t.integer  "number_schools",      limit: 4
    t.string   "group_size",          limit: 255
    t.decimal  "avg_major_crimes",                precision: 4, scale: 2
    t.decimal  "avg_other_crimes",                precision: 4, scale: 2
    t.decimal  "avg_incidents",                   precision: 4, scale: 2
    t.decimal  "avg_property_crimes",             precision: 4, scale: 2
    t.decimal  "avg_violent_crimes",              precision: 4, scale: 2
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "dbn",             limit: 255
    t.string   "name",            limit: 255
    t.string   "boro",            limit: 255
    t.string   "building",        limit: 255
    t.string   "starting_grade",  limit: 255
    t.string   "finishing_grade", limit: 255
    t.string   "address",         limit: 255
    t.string   "website",         limit: 255
    t.integer  "total_students",  limit: 4
    t.string   "school_type",     limit: 255
    t.decimal  "latitude",                    precision: 16, scale: 14
    t.decimal  "longitude",                   precision: 16, scale: 14
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

end

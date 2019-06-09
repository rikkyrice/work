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

ActiveRecord::Schema.define(version: 2019_06_07_184536) do

  create_table "crewshifts", force: :cascade do |t|
    t.integer "user_id"
    t.date "full_date"
    t.integer "already"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mon914"
    t.string "mon10515"
    t.string "mon1115"
    t.string "mon115155"
    t.string "mon1217"
    t.string "mon1722"
    t.string "mon1822"
    t.string "mon228"
    t.string "mon229"
    t.string "tue914"
    t.string "tue10515"
    t.string "tue1115"
    t.string "tue115155"
    t.string "tue1217"
    t.string "tue1722"
    t.string "tue1822"
    t.string "tue228"
    t.string "tue229"
    t.string "wed914"
    t.string "wed10515"
    t.string "wed1115"
    t.string "wed115155"
    t.string "wed1217"
    t.string "wed1722"
    t.string "wed1822"
    t.string "wed228"
    t.string "wed229"
    t.string "thu914"
    t.string "thu10515"
    t.string "thu1115"
    t.string "thu115155"
    t.string "thu1217"
    t.string "thu1722"
    t.string "thu1822"
    t.string "thu228"
    t.string "thu229"
    t.string "fri914"
    t.string "fri10515"
    t.string "fri1115"
    t.string "fri115155"
    t.string "fri1217"
    t.string "fri1722"
    t.string "fri1822"
    t.string "fri19522"
    t.string "fri229"
    t.string "sat914"
    t.string "sat1115"
    t.string "sat115155"
    t.string "sat1217"
    t.string "sat1722"
    t.string "sat1822"
    t.string "sat229"
    t.string "sun914"
    t.string "sun1115"
    t.string "sun115155"
    t.string "sun1217"
    t.string "sun1722"
    t.string "sun1822"
    t.string "sun228"
    t.string "sun229"
  end

  create_table "thatdates", force: :cascade do |t|
    t.integer "date"
    t.date "expire"
    t.date "full_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "partcord"
    t.integer "chief"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
  end

end

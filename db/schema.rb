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

ActiveRecord::Schema.define(:version => 20111015234701) do

  create_table "keiripls", :force => true do |t|
    t.integer  "month_id",                         :null => false
    t.integer  "siten_id",                         :null => false
    t.integer  "uriage",            :default => 0
    t.integer  "siire",             :default => 0
    t.integer  "sitenkan",          :default => 0
    t.integer  "kisyu",             :default => 0
    t.integer  "kimatu",            :default => 0
    t.integer  "kyuryo",            :default => 0
    t.integer  "syoyo",             :default => 0
    t.integer  "taisyoku",          :default => 0
    t.integer  "hotei",             :default => 0
    t.integer  "haken",             :default => 0
    t.integer  "hukuri",            :default => 0
    t.integer  "kokoku",            :default => 0
    t.integer  "sozei",             :default => 0
    t.integer  "tinsyaku",          :default => 0
    t.integer  "tesu",              :default => 0
    t.integer  "yatin",             :default => 0
    t.integer  "syokyaku",          :default => 0
    t.integer  "nenryo",            :default => 0
    t.integer  "tusin",             :default => 0
    t.integer  "konetu",            :default => 0
    t.integer  "ryohi",             :default => 0
    t.integer  "kaigi",             :default => 0
    t.integer  "untin",             :default => 0
    t.integer  "syuzen",            :default => 0
    t.integer  "hoken",             :default => 0
    t.integer  "kurasiki",          :default => 0
    t.integer  "hosyu",             :default => 0
    t.integer  "syomo",             :default => 0
    t.integer  "zimu",              :default => 0
    t.integer  "zappi",             :default => 0
    t.integer  "sonota",            :default => 0
    t.integer  "buturyu",           :default => 0
    t.integer  "henkan",            :default => 0
    t.integer  "zatusyunyu",        :default => 0
    t.integer  "zatusyunyuzeinuki", :default => 0
    t.integer  "uketoririsoku",     :default => 0
    t.integer  "siharairisoku",     :default => 0
    t.integer  "zatusonsitu",       :default => 0
    t.integer  "syohizeimodori",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "months", :force => true do |t|
    t.integer  "month"
    t.integer  "serial"
    t.integer  "year"
    t.integer  "order"
    t.boolean  "fix_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sitens", :force => true do |t|
    t.string   "name",         :limit => 50, :null => false
    t.string   "dispname",     :limit => 50, :null => false
    t.boolean  "summary_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yosans", :force => true do |t|
    t.integer  "month_id",                         :null => false
    t.integer  "siten_id",                         :null => false
    t.integer  "uriage",            :default => 0
    t.integer  "siire",             :default => 0
    t.integer  "sitenkan",          :default => 0
    t.integer  "kisyu",             :default => 0
    t.integer  "kimatu",            :default => 0
    t.integer  "kyuryo",            :default => 0
    t.integer  "syoyo",             :default => 0
    t.integer  "taisyoku",          :default => 0
    t.integer  "hotei",             :default => 0
    t.integer  "haken",             :default => 0
    t.integer  "hukuri",            :default => 0
    t.integer  "kokoku",            :default => 0
    t.integer  "sozei",             :default => 0
    t.integer  "tinsyaku",          :default => 0
    t.integer  "tesu",              :default => 0
    t.integer  "yatin",             :default => 0
    t.integer  "syokyaku",          :default => 0
    t.integer  "nenryo",            :default => 0
    t.integer  "tusin",             :default => 0
    t.integer  "konetu",            :default => 0
    t.integer  "ryohi",             :default => 0
    t.integer  "kaigi",             :default => 0
    t.integer  "untin",             :default => 0
    t.integer  "syuzen",            :default => 0
    t.integer  "hoken",             :default => 0
    t.integer  "kurasiki",          :default => 0
    t.integer  "hosyu",             :default => 0
    t.integer  "syomo",             :default => 0
    t.integer  "zimu",              :default => 0
    t.integer  "zappi",             :default => 0
    t.integer  "sonota",            :default => 0
    t.integer  "buturyu",           :default => 0
    t.integer  "henkan",            :default => 0
    t.integer  "zatusyunyu",        :default => 0
    t.integer  "zatusyunyuzeinuki", :default => 0
    t.integer  "uketoririsoku",     :default => 0
    t.integer  "siharairisoku",     :default => 0
    t.integer  "zatusonsitu",       :default => 0
    t.integer  "syohizeimodori",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zissekis", :force => true do |t|
    t.integer  "month_id",                         :null => false
    t.integer  "siten_id",                         :null => false
    t.integer  "uriage",            :default => 0
    t.integer  "siire",             :default => 0
    t.integer  "sitenkan",          :default => 0
    t.integer  "kisyu",             :default => 0
    t.integer  "kimatu",            :default => 0
    t.integer  "kyuryo",            :default => 0
    t.integer  "syoyo",             :default => 0
    t.integer  "taisyoku",          :default => 0
    t.integer  "hotei",             :default => 0
    t.integer  "haken",             :default => 0
    t.integer  "hukuri",            :default => 0
    t.integer  "kokoku",            :default => 0
    t.integer  "sozei",             :default => 0
    t.integer  "tinsyaku",          :default => 0
    t.integer  "tesu",              :default => 0
    t.integer  "yatin",             :default => 0
    t.integer  "syokyaku",          :default => 0
    t.integer  "nenryo",            :default => 0
    t.integer  "tusin",             :default => 0
    t.integer  "konetu",            :default => 0
    t.integer  "ryohi",             :default => 0
    t.integer  "kaigi",             :default => 0
    t.integer  "untin",             :default => 0
    t.integer  "syuzen",            :default => 0
    t.integer  "hoken",             :default => 0
    t.integer  "kurasiki",          :default => 0
    t.integer  "hosyu",             :default => 0
    t.integer  "syomo",             :default => 0
    t.integer  "zimu",              :default => 0
    t.integer  "zappi",             :default => 0
    t.integer  "sonota",            :default => 0
    t.integer  "buturyu",           :default => 0
    t.integer  "henkan",            :default => 0
    t.integer  "zatusyunyu",        :default => 0
    t.integer  "zatusyunyuzeinuki", :default => 0
    t.integer  "uketoririsoku",     :default => 0
    t.integer  "siharairisoku",     :default => 0
    t.integer  "zatusonsitu",       :default => 0
    t.integer  "syohizeimodori",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

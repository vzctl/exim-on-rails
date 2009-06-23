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

ActiveRecord::Schema.define(:version => 20081212151437) do

  create_table "domain_aliases", :id => false, :force => true do |t|
    t.integer "domain_id", :null => false
    t.integer "alias_id",  :null => false
  end

  create_table "domains", :force => true do |t|
    t.string   "name",                       :default => "",   :null => false
    t.date     "paidtill"
    t.datetime "lastupdate"
    t.boolean  "enabled",                    :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mailboxes_count",            :default => 0,    :null => false
    t.integer  "maillists_count",            :default => 0,    :null => false
    t.integer  "domain_notifications_count", :default => 0,    :null => false
    t.integer  "mailbox_aliases_count",      :default => 0,    :null => false
    t.integer  "aliases_count",              :default => 0,    :null => false
    t.integer  "records_count",              :default => 0,    :null => false
    t.integer  "lock_version",               :default => 0,    :null => false
    t.integer  "quota"
    t.integer  "mailbox_quota"
    t.boolean  "mailbox_greylisting",        :default => true, :null => false
    t.boolean  "mailbox_dnsbl",              :default => true, :null => false
    t.boolean  "mailbox_spf",                :default => true, :null => false
    t.integer  "mailbox_spam_barrier"
    t.boolean  "mailbox_spamscanner",        :default => true, :null => false
    t.boolean  "mailbox_avscanner",          :default => true, :null => false
    t.string   "catch_unroutable"
    t.string   "archive"
  end

  create_table "mailbox_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "mailbox_id",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "domain_id"
    t.integer  "lock_version", :default => 0, :null => false
  end

  create_table "mailboxes", :force => true do |t|
    t.integer  "domain_id",                                 :null => false
    t.string   "name",                                      :null => false
    t.string   "password",               :default => "",    :null => false
    t.integer  "quota"
    t.boolean  "greylisting",            :default => true,  :null => false
    t.boolean  "dnsbl",                  :default => true,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "forward"
    t.integer  "mailbox_aliases_count",  :default => 0,     :null => false
    t.integer  "spam_barrier"
    t.integer  "maillist_members_count", :default => 0,     :null => false
    t.boolean  "spf",                    :default => false, :null => false
    t.integer  "lock_version",           :default => 0,     :null => false
    t.boolean  "enabled",                :default => true,  :null => false
    t.text     "vacation_message"
    t.boolean  "vacation",               :default => false, :null => false
    t.boolean  "spamscanner",            :default => true,  :null => false
    t.boolean  "avscanner",              :default => true,  :null => false
    t.boolean  "spam_catcher",           :default => false
    t.string   "note"
    t.boolean  "keep_forwarded",         :default => true,  :null => false
  end

  create_table "maillist_members", :force => true do |t|
    t.string   "member_type",    :default => "", :null => false
    t.integer  "mailbox_id"
    t.string   "remote_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "maillist_id",                    :null => false
    t.integer  "lock_version",   :default => 0,  :null => false
  end

  create_table "maillists", :force => true do |t|
    t.string   "name",                   :default => "",    :null => false
    t.integer  "domain_id",                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",                 :default => false, :null => false
    t.integer  "maillist_members_count", :default => 0,     :null => false
    t.string   "reply"
    t.integer  "spam_barrier"
    t.boolean  "dnsbl",                  :default => true,  :null => false
    t.boolean  "greylisting",            :default => true,  :null => false
    t.integer  "lock_version",           :default => 0,     :null => false
    t.boolean  "enabled",                :default => true,  :null => false
  end

end

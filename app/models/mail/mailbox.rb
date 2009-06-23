module Mail
  class Mailbox < ActiveRecord::Base
    set_table_name 'mailboxes'
    validates_presence_of  :name, :password
    validates_uniqueness_of :name, :scope => "domain_id"
    validates_numericality_of :spam_barrier, :allow_blank=>true
    validates_inclusion_of  :spam_barrier, :in=>10..200, :allow_blank=>true, :unless => :spam_filter
    validates_associated :domain
    validates_email :name, :level=>0
    validates_email :forward, :allow_blank=>true
    strip_attributes!

    belongs_to :domain, :counter_cache=>true, :class_name=>'Mail::Domain'
    has_many :mailbox_aliases, :dependent => :delete_all, :class_name=>'Mail::MailboxAlias'
    has_many :maillists, :through => :maillist_members, :class_name=>'Mail::Maillist'
    has_many :maillist_members, :dependent => :destroy, :class_name=>'Mail::MaillistMember'
   
    attr_reader :pass
    attr_accessor :pass_confirmation

    def address
      "#{self.name}@#{self.domain.name}" if self.domain
    end

    alias aliases mailbox_aliases
    alias title address

    def spam_filter
      !self.spam_barrier.nil?
    end

    def spam_filter=(v)
      self.spam_barrier=nil if v=='0'
    end

    def pass=(v)
      return @pass if v.blank?
      @pass = v
      self.password = v
    end

  end
end

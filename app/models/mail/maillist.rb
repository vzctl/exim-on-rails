module Mail
  class Maillist < ActiveRecord::Base
    set_table_name 'maillists'
    validates_presence_of  :name
    validates_numericality_of :spam_barrier, :allow_blank=>true
    validates_associated :domain
    validates_uniqueness_of :name, :scope => 'domain_id'
    validates_email :name, :level => 0, :allow_blank => true
    validates_email :reply_custom, :level=>1, :allow_blank=>true
    validates_numericality_of :spam_barrier, :allow_blank=>true
    validates_inclusion_of  :spam_barrier, :in=>10..200, :allow_blank=>true, :unless => :spam_filter
    strip_attributes!


    belongs_to :domain, :counter_cache=>true, :class_name=>'Mail::Domain'

    has_many :maillist_members, :class_name=>'Mail::MaillistMember',
      :dependent => :destroy   do
      def local
        find(:all, :conditions => {:member_type => 'local'})
      end
      def remote
        find(:all, :conditions => {:member_type => 'remote'})
      end
    end

    alias  members maillist_members

    def address
      "#{name}@#{domain.name}"
    end

    alias title address

    #only for existing model
    def reply_flag=(v)
      case v
      when 'maillist'
        self.reply = address
      when "sender"
        self.reply = nil
      end
    end

    def reply_flag
      case reply
      when nil
        'sender'
      when address
        'maillist'
      else
        'custom'
      end
    end

    def reply_custom=(v)
      self.reply = v
    end

    def reply_custom
      self.reply_flag == "custom" ? self.reply : nil
    end

    def spam_filter
      !self.spam_barrier.nil?
    end

    def spam_filter=(v)
      self.spam_barrier=nil unless v
    end
  end
end

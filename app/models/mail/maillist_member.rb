module Mail
  class MaillistMember < ActiveRecord::Base
    set_table_name 'maillist_members'
    include RFC822

    validates_associated :maillist
    validates_associated :mailbox, :if=> :local?
    validates_email :address
    validates_uniqueness_of :mailbox_id, :scope=>:maillist_id, :if => :local?, :allow_blank => true
    validates_uniqueness_of :remote_address, :scope=>:maillist_id, :unless => :local?, :allow_blank => true
    strip_attributes!

    belongs_to :maillist, :counter_cache=>true, :class_name=>'Mail::Maillist'
    belongs_to :mailbox, :counter_cache=>true, :class_name=>'Mail::Mailbox'

    def address
      case member_type
      when 'local'
        "#{self.mailbox.address}"
      when 'remote'
        remote_address
      end
    end

    alias title address

    def address=(addr)
      return unless addr
      m = addr.match(EmailSpec).to_a
      unless m.blank?
        if (d=Domain.find_by_name(m[2]))
          self.member_type = 'local' if self.mailbox=d.mailboxes.find_by_name(m[1])
        else
          self.remote_address=addr;self.member_type = 'remote'
        end
      end
    end

    def local?
      self.member_type=='local'
    end

  end
end

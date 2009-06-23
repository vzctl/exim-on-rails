module Mail
  class MailboxAlias < ActiveRecord::Base
    set_table_name 'mailbox_aliases'
    include RFC822
    validates_presence_of :name, :mailbox_id, :domain_id
    validates_uniqueness_of :name, :scope => "domain_id"
    validates_associated :domain, :mailbox
    validates_email :name, :level => 0
    validates_email :address
    strip_attributes!

    belongs_to :mailbox, :counter_cache=>true, :class_name=>'Mail::Mailbox'
    belongs_to :domain, :counter_cache=>true, :class_name=>'Mail::Domain'

    def address
      "#{self.name}@#{self.domain.name}" if self.domain
    end

    alias title address

    def address=(addr)
      m = addr.match(EmailSpec).to_a
      if !m.blank?
        if (d=Domain.find_by_name(m[2]))
          if d.mailboxes.find_by_name(m[1])
            self.errors.add :address, "already existing on local domain"
          else
            self.domain=d;self.name=m[1]
          end
        else
          self.errors.add :address, "is not on local domains"
        end
      end
    end

  end
end

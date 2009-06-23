module Mail
  class Domain < ActiveRecord::Base
    set_table_name 'domains'
    validates_presence_of :name
    validates_uniqueness_of :name
    validates_domain :name, :allow_blank=>true
    validates_inclusion_of  :mailbox_spam_barrier, :in=>10..200, :allow_blank=>true
    strip_attributes!

    #Mail associations
    has_many :mailboxes, :dependent => :destroy, :order => '`mailboxes`.`name`', :class_name=>'Mail::Mailbox' do    |a|
      def build (attributes = {})
        attributes.reverse_merge!(
          :spf=>@owner.mailbox_spf,
          :dnsbl => @owner.mailbox_dnsbl,
          :greylisting => @owner.mailbox_greylisting
        )
        attributes.reverse_merge!(:spam_barrier => @owner.mailbox_spam_barrier) unless attributes.include?(:spam_filter)
        super
      end
    end
    has_many :maillists, :dependent => :destroy, :order => '`maillists`.`name`', :class_name=>'Mail::Maillist'
    has_many :mailbox_aliases, :dependent => :destroy, :class_name=>'Mail::MailboxAlias'
    #has_many :spam_catchers, :dependent => :destroy, :order => '`spam_catchers`.`name`'

    has_and_belongs_to_many :aliases,
      :class_name => 'Mail::Domain',
      :join_table=>:domain_aliases,
      :foreign_key => 'domain_id',
      :association_foreign_key => 'alias_id',
      :after_add => lambda{ |d, a| d.update_attribute :aliases_count,(d.aliases_count+1) ;a.update_attribute :enabled, true},
      :after_remove=>lambda{ |d, a| d.update_attribute :aliases_count,(d.aliases_count-1) ;a.update_attribute :enabled, false}

    def alias_parent
      if (! aliases.blank?)
        nil
      else
        for domain in Domain.find :all do
          if domain.aliases.include?(self)
            return domain
          end
        end
        return nil
      end
    end

    def mailbox_spam_filter
      !self.mailbox_spam_barrier.nil?
    end

    def mailbox_spam_filter=(v)
      self.mailbox_spam_barrier=nil if v=='0'
    end

  end
end

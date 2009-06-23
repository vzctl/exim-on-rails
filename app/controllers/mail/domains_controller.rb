class Mail::DomainsController < MailController
  before_filter :init_domain, :only => [:actions, :destroy, :edit, :update]

  def index
    @domains = Mail::Domain.find(:all, :include => [:aliases], :order=>"`domains`.`name`")
    @aliased_domains = []
    @parent_domains = []

    @domains.each do |domain|
      domain.aliases.each  do |a|
        @aliased_domains << a
      end
    end

    @domains.each do |d|
      @parent_domains << d unless @aliased_domains.include?(d)
    end
  end

  def create
    @domain = Mail::Domain.new(params[:domain])
    if @domain.save
      flash[:notice] = t('common.flash.created')
      redirect_to mail_domains_path
    else
      render :action => :new
    end
  end

  def new
    @domain = Mail::Domain.new
  end

  def edit
  end

  def update
    if @domain.update_attributes(params[:domain])
      flash[:notice] = t('common.flash.updated')
      if params[:reset_spam_options]
        spam_attributes = params[:domain].reject do |key,value|
          !(['mailbox_spf','mailbox_dnsbl','mailbox_greylisting','mailbox_spam_barrier'].include? key)
        end
        update_string = spam_attributes.to_query.gsub('&',',').gsub('mailbox_','')
        unless Mailbox.update_all(update_string, "`domain_id`= #{@domain.id}")
          flash[:error] = t('common.flash.error')
        end
      end
      redirect_to mail_domains_path
    else
      render :action => :edit
    end
  rescue ActiveRecord::StaleObjectError
    @domain.reload
    flash[:error] = t('common.flash.staled')
    render :action => :edit
  end

  def toggle

  end

  def destroy
    @domain.aliases.destroy_all
    @domain.mailbox_aliases.destroy_all
    @domain.mailboxes.destroy_all
    @domain.maillists.destroy_all
    @domain.destroy
    flash[:notice] = t('common.flash.deleted')
    redirect_to mail_domains_path
  end
end

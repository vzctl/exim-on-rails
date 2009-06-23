class Mail::MailboxesController < MailController

  before_filter :init_parent_domain
  before_filter :init_mailbox, :only=>[ :subscribe, :edit, :update, :destroy]

  def index
    @mailboxes=@domain.mailboxes.find(:all,:include =>[:domain,{:mailbox_aliases=>[:domain]}],:order=>"`mailboxes`.`name`")
  end

  def new
    @mailbox=@domain.mailboxes.build
  end

  def create
    @mailbox = @domain.mailboxes.build(params[:mailbox])
    if @mailbox.save
      flash[:notice] = t('common.flash.created')
      redirect_to mail_domain_mailboxes_path(params[:domain_id])
    else
      render :action => :new
    end
  end

  def show
  end

  def subscribe
    @maillist = Mail::Maillist.find(params[:maillist][:id])
    @member = @maillist.members.build(:mailbox_id=>@mailbox.id, :member_type=>'local')
    if (@member.save)
      flash[:notice]   = t('common.flash.updated')
    end
    redirect_to request.referer
  end

  def maillists
    @mailbox = @domain.mailboxes.find(params[:id], :include => [:domain,{:maillist_members=>[{:maillist=>[:domain]}]}])
    @maillists = Mail::Maillist.find(:all, :include=>[:domain]).reject{|ml|@mailbox.maillists.include?(ml)}
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    if @mailbox.update_attributes(params[:mailbox])
      flash[:notice] = t('common.flash.updated')
      redirect_to mail_domain_mailboxes_path(@domain)
    else
      render :action => :edit
    end
  rescue ActiveRecord::StaleObjectError
    @mailbox.reload
    flash[:error] = t('common.flash.staled')
    render :action => :edit
  end

  def destroy
    if @mailbox.destroy
      flash[:notice] = t('common.flash.deleted')
    end
    redirect_to mail_domain_mailboxes_path(@domain)
  end
end

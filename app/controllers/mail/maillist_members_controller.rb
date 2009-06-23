class Mail::MaillistMembersController < MailController
  before_filter :init_parent_domain
  before_filter :init_parent_maillist

  def index
    # :include=>[{:mailbox=>[:domain]}],
    @members=@maillist.members.find(:all,
      :order=>'`maillist_members`.`member_type`, `maillist_members`.`remote_address`')
  end

  def new
    @member = @maillist.members.build
  end

  def create
    @member = @maillist.members.build
    if (@member.address  = params[:address]) && @member.save
      flash[:notice] = t('common.flash.created')
      redirect_to request.referer
    else
      render :action => :new
    end
  end

  def destroy
    if @maillist.members.find(params[:id]).destroy
      flash[:notice] =  t('common.flash.deleted')
    end
    redirect_to request.referer
  end

end

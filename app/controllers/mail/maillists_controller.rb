class Mail::MaillistsController < MailController

  before_filter :init_parent_domain, :exclude=>[:index]
  before_filter :init_maillist, :only => [:edit,:update,:destroy]

  def index
    @domain = Mail::Domain.find(params[:domain_id], :include => [{:maillists=>[:domain]}], :order=>'`maillists`.`name`')
  end

  def new
    @maillist = @domain.maillists.build
  end

  def create
    @maillist = @domain.maillists.build
    @maillist.attributes = params[:maillist]

    if @maillist.save
      flash[:notice] =  t('common.flash.created')
      redirect_to request.referer
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @maillist.update_attributes(params[:maillist])
      flash[:notice] =  t('common.flash.updated')
      redirect_to request.referer
    else
      render :action => :edit
    end
  end

  def destroy
    if @maillist.destroy
      flash[:notice] = t('common.flash.deleted')
    end
    redirect_to request.referer
  end

end

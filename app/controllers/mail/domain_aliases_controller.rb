class Mail::DomainAliasesController < MailController
  layout false
  before_filter :init_parent_domain

  def index
  end

  def new
  end

  def create
    @alias = Mail::Domain.new(params[:alias])
    if @alias.save
      @domain.aliases << @alias
    else
      render :update do |page|
        page.alert @alias.errors.full_messages
      end
    end
  end

  def destroy
    @alias = Mail::Domain.find(params[:id])
    if @domain.aliases.delete(@alias)
      render :update do |page|
        page.remove "mail_domain_#{params[:id]}"
      end
      @alias.destroy
    end
  end

end

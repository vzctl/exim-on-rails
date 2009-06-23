class Mail::MailboxAliasesController < MailController
  layout :false
  before_filter :init_parent_domain, :init_parent_mailbox

  def  new
  end

  def create
    @alias = @mailbox.aliases.new(params[:alias])
    unless @alias.save
      render :update do |page|
        page.alert @alias.errors.full_messages
      end
    end
  end

  def destroy
    if @mailbox.mailbox_aliases.find(params[:id]).destroy
      render :update do |page|
        page.remove "mailbox_alias_#{params[:id]}"
      end
    end
  end

end

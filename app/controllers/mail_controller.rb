class MailController < ApplicationController

  protected

  def init_domain
    @domain = Mail::Domain.find(params[:id])
  end

  def init_parent_domain
    @domain = Mail::Domain.find(params[:domain_id])
  end

  def init_mailbox
    @mailbox = @domain.mailboxes.find(params[:id])
  end

  def init_parent_mailbox
    @mailbox = @domain.mailboxes.find(params[:mailbox_id])
  end

  def init_maillist
    @maillist =  @domain.maillists.find(params[:id])
  end

  def init_parent_maillist
    @maillist =  @domain.maillists.find(params[:maillist_id])
  end

end

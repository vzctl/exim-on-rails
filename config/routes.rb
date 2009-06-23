ActionController::Routing::Routes.draw do |map|
  map.namespace 'mail'  do |mail|
    mail.root :controller => :domains
    mail.resources :domains, :member=>{:toggle=>:put} do |domain|
      domain.resources :aliases, :controller => 'domain_aliases'
      domain.resources :mailboxes , :member=>{:maillists=>:get, :subscribe=>:post, :actions=> :get }do |mailbox|
        mailbox.resources :aliases,  :controller =>'mailbox_aliases'
      end
      domain.resources :maillists  do |maillist|
        maillist.resources :members, :controller => 'maillist_members'
      end
    end
  end


  map.root :controller => 'mail/domains', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

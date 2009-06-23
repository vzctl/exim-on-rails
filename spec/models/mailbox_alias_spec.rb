require File.dirname(__FILE__) + '/../spec_helper'  

describe Mail::MailboxAlias do
  before(:each) do
    @domain=Mail::Domain.create(:name=>"#{String.random}.#{String.random}",:enabled=>true)
    @mailbox=@domain.mailboxes.create(:name=>String.random, :password=>String.random)
    @mailbox_alias = @mailbox.aliases.create(:name=>String.random, :domain=>@domain)
  end

  it "should have correct address" do
    @mailbox_alias.address.should == "#{@mailbox_alias.name}@#{@domain.name}"
  end
  
  it "should parse local address" do
    alias_name=String.random
    alias_address="#{alias_name}@#{@domain.name}"
    @new_mailbox_alias=@mailbox.aliases.build(:address=>alias_address)
    @new_mailbox_alias.domain.should == @domain
    @new_mailbox_alias.name.should == alias_name
    @new_mailbox_alias.address.should == alias_address
    @new_mailbox_alias.should be_valid
  end
  
  it "should not parse remote address" do
    alias_name=String.random
    alias_domain=String.random
    alias_address="#{alias_name}@#{alias_domain}"
    @new_mailbox_alias=@mailbox.aliases.build(:address=>alias_address)
    @new_mailbox_alias.should_not be_valid
  end
  
  it "should be valid" do
    @mailbox_alias.should be_valid
  end
  
  after(:all) do
    Mail::Domain.delete_all
  end
  
end

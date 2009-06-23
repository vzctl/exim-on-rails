require File.dirname(__FILE__) + '/../spec_helper'

describe Mail::Mailbox do
  before(:each) do
    @domain = Mail::Domain.create :name=>"#{String.random}.#{String.random}", :enabled=>true
    @mailbox = @domain.mailboxes.create :name=>String.random,:password=>String.random
  end

  it "should have correct address" do
    @mailbox.address.should == "#{@mailbox.name}@#{@domain.name}"
  end
  
  it "should be valid" do
    @mailbox.should be_valid
  end
  
  after(:all) do
    Mail::Domain.delete_all
  end

end

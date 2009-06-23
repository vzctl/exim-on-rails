require File.dirname(__FILE__) + '/../spec_helper'

describe Mail::Maillist do
  before(:each) do
    @domain = Mail::Domain.create :name=>"#{String.random}.#{String.random}", :enabled=>true
    @maillist = @domain.maillists.create :name=>String.random
  end
  
  it "should have correct address" do
    @maillist.address.should == "#{@maillist.name}@#{@domain.name}"
  end
  
  it "should define correct return address" do
    @maillist.update_attributes(:reply_flag=>'maillist')
    @maillist.reply.should == @maillist.address
    @maillist.reply_custom.should == nil
    @maillist.update_attributes(:reply_flag=>'sender')
    @maillist.reply.should == nil
    @maillist.reply_custom.should == nil
    custom_address="#{String.random}@#{String.random}"
    @maillist.update_attributes(:reply_flag=>'custom',:reply_custom=>custom_address)    
    @maillist.reply.should == custom_address
    @maillist.reply_custom.should == custom_address
  end
 
  it "should reject wrong custom address" do
    wrong_custom_address=String.random
    @maillist.update_attributes(:reply_flag=>'custom',:reply_custom=>wrong_custom_address)    
    @maillist.should_not be_valid
  end
  
  it "should be valid" do
    @maillist.should be_valid
  end
  
  after(:all) do
    Mail::Domain.delete_all
  end

end

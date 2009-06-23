require File.dirname(__FILE__) + '/../spec_helper'

describe Mail::MaillistMember do
  before(:each) do
    @domain=Mail::Domain.create(:name=>"#{String.random}.#{String.random}",:enabled=>true)
    @maillist=@domain.maillists.create(:name=>String.random)
    @mailbox=@domain.mailboxes.create(:name=>String.random,:password=>String.random)
    @remote_member_address="#{String.random}@#{String.random}.#{String.random}"
    #@remote_member =@maillist.members.build
    #@remote_member.address = @remote_member_address
    #@remote_member.save
    @remote_member = @maillist.members.create(:address=>@remote_member_address)
    @local_member = @maillist.members.create(:address=>@mailbox.address)
  end
  
  it "should correct parse address" do
    @remote_member.member_type.should == 'remote'
    @local_member.member_type.should == 'local'
    @local_member.address.should == @mailbox.address
    @remote_member.address.should == @remote_member_address
  end
  
  it "should reject wrong address" do
    wrong_member=@maillist.members.create(:address=>String.random)
    wrong_member.should_not be_valid
  end
  
  it "should be valid" do
    @remote_member.should be_valid    
    @local_member.should be_valid
  end
  
  after(:all) do
    Mail::Domain.delete_all
  end

end

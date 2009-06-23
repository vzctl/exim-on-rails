require File.dirname(__FILE__) + '/../spec_helper'

describe Mail::Domain, :behaviour_type=>:model do
  before(:each) do
    @domain = Mail::Domain.create :name=>String.random+'.com', :enabled=>true
  end

  it "should has many aliases" do
    create_aliases
    @domain.aliases<<@aliases
    @domain.aliases.sort_by(&:id).should == @aliases.sort_by(&:id)
  end

  it "aliases should have correct alias_parent" do
    create_aliases
    @domain.aliases.each {|a|  a.alias_parent.should == @domain  }
    @domain.alias_parent.should == nil
  end

  it "aliases should be correctly destroyed after parent remove" do
    create_aliases(20)
    @domain.aliases << @aliases
    @domain.destroy
    @aliases.length.should == 20
    @aliases.each {|a|a.reload.enabled.should == false}
  end

 it "should be valid" do
    @domain.should be_valid
  end

  after(:all) do
    Mail::Domain.delete_all
  end

  def create_aliases(aliases_count=15)
    @aliases=[]
    aliases_count.times do
        @aliases << Mail::Domain.create(:name=>"#{String.random}.#{String.random}", :enabled=>true)
     end
  end
end

require 'spec_helper'
require 'rfc822'
include RFC822

describe RFC822 do

  valid_addresses=["cal@iamcalx.com", "cal_test@iamcalx.com", "_sd@iamcalx.com"]
  invalid_addresses=["cal henderson@iamcalx.com","cal@iamcalx com","cal@hello world.com","cal@[hello].com","cal@[hello world].com",
  		"cal@[hello\ world].com", "abcdefghijklmnopqrstuvwxyz@abcdefghijklmnopqrstuvwxyz","cal@iamcalx","user.@domain.com"]
  valid_domains=["www.ru"]
  invalid_domains=["_.["]

  it "should correct domain match" do
    valid_domains.each do |domain|
        domain.should =~ DomainSpec
    end  
    invalid_domains.each do |domain|
        domain.should_not =~ DomainSpec
    end

  end

  it "should correct address match" do
    valid_addresses.each do |address|
    	address.should =~ EmailSpec
	address.match(EmailSpec).to_a[2].should =~ DomainPartSpec
	address.match(EmailSpec).to_a[1].should =~ LocalPartSpec
    end
    invalid_addresses.each do |address|
        address.should_not =~ EmailSpec
    end
    
  end
end


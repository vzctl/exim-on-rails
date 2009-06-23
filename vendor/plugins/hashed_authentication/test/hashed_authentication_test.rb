require File.dirname(__FILE__)+'/helper.rb'

class HashedAuthenticationTest < ActiveRecordTestCase
  # Replace this with your real tests.
  def test_hashed_authentication
    assert_equal ActiveRecord::Base.methods.grep('hashed_authentication'), ['hashed_authentication']
    assert_equal Empty.methods.grep('authenticate'), []
    assert_equal User.methods.grep('authenticate'), ['authenticate']
    u=User.new
    [:password, :password=, :hash_for_password, :password_correct?].each do |m|
      assert u.respond_to?(m)
    end
  end
  
  def test_instance_methods
    u=User.new(:login => 'test')
    u.password= '123456'
    assert_equal(u.password, '123456')
    assert_equal(u.hashed_password.length, 128)
    assert_equal(u.salt.length>0, true)
    assert_equal(u.password_correct?('123456'), true)
    assert_equal(u.password_correct?('12345'),  false)
  end
  
  def test_complex
    u=User.new(:login => 'test', :password => '123456')
    u.save!
    
    assert_equal User.authenticate('test', '123456'), u.id
    assert_equal User.authenticate('test', '12345'), false
    assert_equal User.authenticate('login', 'fasdf'), false
  end
  
  def test_empty_password
    u=User.new(:login => 'test', :password => "123456")
    hp=u.hashed_password
    u.password = ''
    assert_equal(hp, u.hashed_password)
  end
end

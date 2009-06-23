# HashedAuthentication
module HashedAuthentication
  module InstanceMethods
    attr_accessor :password_confirmation
    attr_reader :password

    def password=(val)
      return @password if val.blank?
      
      @password=val

      self.salt=generate_salt
      self.hashed_password=hash_for_password(self.salt, val)

      @password
    end

    def generate_salt
      chars=Array('0'..'9')+Array('a'..'z')+Array('A'..'Z')+['!', '@', '#', '$', '%', '^', '&', '*', '{', '}', '(', ')', '+', '_', '-']

      salt=''
      (5+rand(5)).times{ salt += chars[rand(chars.length)] }

      salt
    end

    def hash_for_password(salt, pass)
      require 'digest/sha2'
      Digest::SHA512.hexdigest(salt+'blg'+Digest::SHA512.hexdigest(pass))
    end

    def password_correct?(pass)
      hash_for_password(self.salt, pass) == self.hashed_password
    end
  end
  
  module ClassMethods
    def authenticate(login, password)
      u=find_by_login(login)
      return false unless u
      return u.id if u.password_correct? password
      false
    end
  end
end

class ActiveRecord::Base
  class<<self
    def hashed_authentication
      self.send :include, HashedAuthentication::InstanceMethods
      self.extend HashedAuthentication::ClassMethods
    end
  end
end


require 'real_validates'

class ActiveRecord::Base
  class << self # Class methods
    include RealValidates
  end  
end

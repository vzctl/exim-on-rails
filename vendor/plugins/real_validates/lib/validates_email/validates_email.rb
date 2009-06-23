require 'validates_email/email_validation'
module ActiveRecord
  module Validations
    module ClassMethods
      def validates_email(*attr_names)
        configuration = { :message => "^Invalid email address", :level => 1, :from=>"here@example.com",  :pass_on_unable_to_verify => true, :on => :save }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)


        validates_each(attr_names, configuration) do |record, attr_name, value|
          record.errors.add(attr_name, configuration[:message]) unless EmailValidation.valid_email?(value, configuration[:level], configuration[:pass_on_unable_to_verify], configuration[:from])
        end
      end
    end
  end
end

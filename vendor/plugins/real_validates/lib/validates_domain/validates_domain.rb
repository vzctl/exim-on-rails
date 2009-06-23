require 'validates_domain/domain_validation'
module ActiveRecord
  module Validations
    module ClassMethods
      def validates_domain(*attr_names)
        configuration = { :message => "^Invalid domain", :level => 1,  :pass_on_unable_to_verify => true, :on => :save }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_each(attr_names, configuration) do |record, attr_name, value|
          record.errors.add(attr_name, configuration[:message]) unless DomainValidation.valid_domain?(value, configuration[:level], configuration[:pass_on_unable_to_verify])
        end
      end
    end
  end
end

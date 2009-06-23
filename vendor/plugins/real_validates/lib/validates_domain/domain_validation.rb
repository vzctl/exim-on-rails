require 'rfc822.rb'
class DomainValidation
  include RFC822
  def self.valid_domain?(address, level = 1, pass_on_unable_to_verify = true)
    vdf = valid_domain_format?(address)
    return true if (vdf && level == 1)
    false #todo
  end

  def self.valid_domain_format?(address)
    address =~ DomainSpec
  end
end

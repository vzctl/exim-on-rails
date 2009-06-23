require 'spec'

class Spec::Context
  # Append any helpers here, but prepend them with an underscore (_) or else
  # they will be executed as specs
end

class FalseClass
  def blank?
    true
  end
end

class NilClass
  def blank?
    false
  end
end

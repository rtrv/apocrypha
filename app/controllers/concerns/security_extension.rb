require 'active_support/concern'

module SecurityExtension
  def should_be_implemented(method_name)
    raise "`#{method_name}` should be implemented for #{self.class.name}"
  end
end

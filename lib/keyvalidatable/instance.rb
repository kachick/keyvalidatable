module KeyValidatable

  # @param [Hash] requirements
  def validate_keys(requirements)
    KeyValidatable.__send__ __callee__, self, requirements
  end
  
  alias_method :validate_members, :validate_keys
  alias_method :assert_keys, :validate_keys
  
  # @param [Hash] requirements
  def valid_keys?(requirements)
    KeyValidatable.__send__ __callee__, self, requirements
  end
  
  alias_method :valid_members?, :valid_keys?

end

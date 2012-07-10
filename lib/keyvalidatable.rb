# Copyright (C) 2012 Kenichi Kamiya

module KeyValidatable

  VERSION = '0.0.1'.freeze
  
  class InvalidKeysError < KeyError; end
  
  class << self
    
    # @param [Hash, Struct] key_value_pairs
    # @param [Hash] requirements
    def validate_keys(key_value_pairs, requirements)
      unless requirements.keys.all?{|key|[:must, :let].include? key}
        raise ArgumentError
      end
      
      unless (requirements[:must] & requirements[:let]).empty?
        raise ArgumentError 
      end
      
      shortage_keys = shortage_keys(key_value_pairs, requirements)
      excess_keys   = excess_keys(key_value_pairs, requirements)
      
      unless [*shortage_keys, *excess_keys].empty?
        raise InvalidKeysError, "Shortage: #{shortage_keys} / Excess: #{excess_keys}"
      end
    end
    
    alias_method :validate_members, :validate_keys

    # @param [Hash, Struct] key_value_pairs
    # @param [Hash] requirements
    def valid_keys?(key_value_pairs, requirements)
      validate_keys(key_value_pairs, requirements)
    rescue InvalidKeysError
      false
    else
      true
    end
    
    alias_method :valid_members?, :valid_keys?

    private
    
    def shortage_keys(key_value_pairs, requirements)
      requirements.fetch(:must) - key_value_pairs.keys
    end
    
    def excess_keys(key_value_pairs, requirements)
      (key_value_pairs.keys - requirements.fetch(:must)) - requirements.fetch(:let)
    end
  
  end

  # @param [Hash] requirements
  def validate_keys(requirements)
    KeyValidatable.validate_keys self, requirements
  end
  
  alias_method :validate_members, :validate_keys
  
  # @param [Hash] requirements
  def valid_keys?(requirements)
    KeyValidatable.valid_keys? self, requirements
  end
  
  alias_method :valid_members?, :valid_keys?

end



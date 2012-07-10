# Copyright (C) 2012 Kenichi Kamiya

module KeyValidatable

  VERSION = '0.0.1'.freeze
  
  class << self
    
    # @param [Hash, Struct] key_value_pairs
    # @param [Hash] requirements
    def valid_keys?(key_value_pairs, requirements)
      keys = key_value_pairs.keys

      unless requirements.keys.all?{|key|[:must, :let].include? key}
        raise ArgumentError
      end
      
      unless (requirements[:must] & requirements[:let]).empty?
        raise ArgumentError 
      end
      
      shortage = requirements[:must] - keys
      excess = keys - (requirements[:must] + requirements[:let])

      [*shortage, *excess].empty?
    end
    
    alias_method :valid_members?, :valid_keys?
    
    # @param [Hash, Struct] key_value_pairs
    # @param [Hash] requirements
    def validate_keys(key_value_pairs, requirements)
      raise KeyError unless valid_keys?(key_value_pairs, requirements)
    end
    
    alias_method :validate_members, :validate_keys
    
  end
  
  # @param [Hash] requirements
  def valid_keys?(requirements)
    KeyValidatable.valid_keys? self, requirements
  end
  
  alias_method :valid_members?, :valid_keys?
  
  # @param [Hash] requirements
  def validate_keys(requirements)
    KeyValidatable.validate_keys self, requirements
  end
  
  alias_method :validate_members, :validate_keys

end



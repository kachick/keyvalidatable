# Copyright (C) 2012 Kenichi Kamiya

module KeyValidatable

  class << self
    
    # @param [Hash, Struct] key_value_pairs
    # @param [Hash] requirements
    # @option requirements [Array] :must
    # @option requirements [Array] :let
    # @return [nil]
    # @raise [InvalidKeysError] when pairs is deficient for requirements
    def validate_keys(key_value_pairs, requirements)
      assert_requirements requirements
      musts, lets = musts_for(requirements), lets_for(requirements)
      
      shortage_keys = shortage_keys key_value_pairs, musts
      excess_keys   = excess_keys key_value_pairs, musts, lets
      
      unless [*shortage_keys, *excess_keys].empty?
        raise InvalidKeysError,
              "Shortage: #{shortage_keys} / Excess: #{excess_keys}"
      end
      
      nil
    end
    
    alias_method :validate_members, :validate_keys
    alias_method :assert_keys, :validate_keys

    # @param [Hash, Struct] key_value_pairs
    # @param [Hash] requirements
    # @option requirements [Array] :must
    # @option requirements [Array] :let
    def valid_keys?(key_value_pairs, requirements)
      assert_requirements requirements
      validate_keys(key_value_pairs, requirements)
    rescue InvalidKeysError
      false
    else
      true
    end
    
    alias_method :valid_members?, :valid_keys?

    private
    
    def shortage_keys(key_value_pairs, musts)
      musts - key_value_pairs.keys
    end
    
    def excess_keys(key_value_pairs, musts, lets)
      (key_value_pairs.keys - musts) - lets
    end
    
    def assert_requirements(requirements)
      raise ArgumentError unless requirements.respond_to? :keys

      unless (requirements.keys - [:must, :let]).empty?
        raise ArgumentError
      end
      
      musts, lets = requirements[:must], requirements[:let]
      
      if musts 
        unless musts.kind_of?(Array) &&
               musts.all?{|key|key.respond_to?(:hash) && key.respond_to?(:eql?)}
          raise TypeError
        end
      end
      
      if lets
        unless lets.kind_of?(Array) &&
               lets.all?{|key|key.respond_to?(:hash) && key.respond_to?(:eql?)}
          raise TypeError
        end
      end
      
      unless musts || lets
        raise TypeError
      end
      
      if requirements.values.inject(&:+).empty?
        raise ArgumentError
      end
    end
    
    def musts_for(requirements)
      requirements[:must] || []
    end
    
    def lets_for(requirements)
      requirements[:let] || []
    end
  
  end

end

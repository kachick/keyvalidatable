# coding: us-ascii
# frozen_string_literal: true

module KeyValidatable
  class << self
    # @param [Hash, #to_hash, #to_h, Struct, #keys, #members] key_value_pairs
    # @param [Hash] requirements
    # @option requirements [Array] :must
    # @option requirements [Array] :let
    # @return [nil]
    # @raise [InvalidKeysError] if pairs is deficient for requirements
    def validate_keys_in_pairs(key_value_pairs, requirements)
      validate_array(keys_for(key_value_pairs), requirements)
    end

    alias_method :validate_keys, :validate_keys_in_pairs
    alias_method :validate_members_in_pairs, :validate_keys_in_pairs
    alias_method :validate_members, :validate_members_in_pairs
    alias_method :assert_keys_in_pairs, :validate_keys_in_pairs
    alias_method :assert_members_in_pairs, :validate_keys_in_pairs
    alias_method :assert_keys, :assert_keys_in_pairs
    alias_method :assert_members, :assert_members_in_pairs

    # @param [Array, #to_ary] keys
    # @param [Hash] requirements
    # @option requirements [Array] :must
    # @option requirements [Array] :let
    # @return [nil]
    # @raise [InvalidKeysError] if pairs is deficient for requirements
    def validate_array(keys, requirements)
      assert_requirements(requirements)
      musts, lets = musts_for(requirements), lets_for(requirements)

      shortage_keys = shortage_elements(keys.to_ary, musts)
      excess_keys   = excess_elements(keys.to_ary, musts, lets)

      unless [*shortage_keys, *excess_keys].empty?
        raise InvalidKeysError,
              "Shortage: #{shortage_keys} / Excess: #{excess_keys}"
      end

      nil
    end

    # @param [Hash, #to_hash, #to_h, Struct, #keys, #members] key_value_pairs
    # @param [Hash] requirements
    # @option requirements [Array] :must
    # @option requirements [Array] :let
    def valid_keys?(key_value_pairs, requirements)
      valid_array?(keys_for(key_value_pairs), requirements)
    end

    alias_method :valid_members?, :valid_keys?

    # @param [Array, #to_ary] keys
    # @param [Hash] requirements
    # @option requirements [Array] :must
    # @option requirements [Array] :let
    def valid_array?(keys, requirements)
      assert_requirements(requirements)
      validate_array(keys, requirements)
    rescue InvalidKeysError
      false
    else
      true
    end

    # @param [Hash, #to_hash, #to_h, Struct, #keys, #members] key_value_pairs
    # @return [Array]
    def keys_for(key_value_pairs)
      pairs = (
        case
        when key_value_pairs.respond_to?(:to_hash)
          key_value_pairs.to_hash
        when key_value_pairs.respond_to?(:to_h)
          key_value_pairs.to_h
        else
          key_value_pairs
        end
      )

      case
      when pairs.respond_to?(:keys)
        pairs.keys
      when pairs.respond_to?(:members)
        pairs.members
      else
        raise TypeError, "#{key_value_pairs.inspect} is not pairs object"
      end
    end

    private

    def shortage_elements(elements, musts)
      musts - elements
    end

    def excess_elements(elements, musts, lets)
      (elements - musts) - lets
    end

    # @param [Hash] requirements
    def assert_requirements(requirements)
      raise ArgumentError unless requirements.respond_to?(:keys)

      unless (requirements.keys - [:must, :let]).empty?
        raise ArgumentError
      end

      musts, lets = requirements[:must], requirements[:let]

      if musts
        unless musts.kind_of?(Array) &&
               musts.all? { |key| key.respond_to?(:hash) && key.respond_to?(:eql?) }
          raise TypeError
        end
      end

      if lets
        unless lets.kind_of?(Array) &&
               lets.all? { |key| key.respond_to?(:hash) && key.respond_to?(:eql?) }
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

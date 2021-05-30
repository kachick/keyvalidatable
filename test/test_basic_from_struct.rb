# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'
require_relative '../lib/keyvalidatable/refinements'

module TestBasicFromStruct
  using KeyValidatable::Refinements

  requirements = {must: [:a, :c], let: [:b]}

  Declare.describe do
    The(Struct.new(:a, :b, :c).new.valid_keys?(requirements)) do
      is true
    end

    The(Struct.new(:a, :c).new) do |sufficient|
      The sufficient.valid_keys?(requirements) do
        is true
      end

      The sufficient.validate_keys(requirements) do
        is nil
      end

      The KeyValidatable.keys_for(sufficient) do
        is [:a, :c]
      end
    end

    The(Struct.new(:a, :b).new) do |shortage|
      The shortage.valid_keys?(requirements) do
        is false
      end

      CATCH KeyValidatable::InvalidKeysError do
        shortage.validate_keys(requirements)
      end

      The KeyValidatable.keys_for(shortage) do
        is [:a, :b]
      end
    end

    The(Struct.new(:a, :b, :c, :d).new) do |excess|
      The excess.valid_keys?(requirements) do
        is false
      end

      CATCH KeyValidatable::InvalidKeysError do
        excess.validate_keys(requirements)
      end

      The KeyValidatable.keys_for(excess) do
        is [:a, :b, :c, :d]
      end
    end
  end
end

Declare.describe do
  The(Struct.new(:a, :b, :c).new) do |struct|
    CATCH NoMethodError do
      struct.valid_keys?({})
    end
  end
end

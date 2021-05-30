# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'
require_relative '../lib/keyvalidatable/refinements'

module TestLetFromStruct
  using KeyValidatable::Refinements

  requirements = {let: [:b]}

  Declare.describe do
    The(Struct.new(:a, :b, :c).new.valid_keys?(requirements)) do
      is false
    end

    The(Struct.new(:b).new) do |sufficient|
      The sufficient.valid_keys?(requirements) do
        is true
      end

      The sufficient.validate_keys(requirements) do
        is nil
      end
    end

    The(Struct.new(:a).new) do |shortage|
      The shortage.valid_keys?(requirements) do
        is false
      end

      CATCH KeyValidatable::InvalidKeysError do
        shortage.validate_keys(requirements)
      end
    end

    The(Struct.new(:a, :b).new) do |excess|
      The excess.valid_keys?(requirements) do
        is false
      end

      CATCH KeyValidatable::InvalidKeysError do
        excess.validate_keys(requirements)
      end
    end
  end
end

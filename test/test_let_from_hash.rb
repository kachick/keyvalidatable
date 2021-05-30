# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'
require_relative '../lib/keyvalidatable/refinements'

module TestLetFromHash
  using KeyValidatable::Refinements

  requirements = {let: [:b]}

  Declare.describe do
    The({a: nil, b: nil, c: nil}.valid_keys?(requirements)) do
      is false
    end

    The({b: nil}) do |sufficient|
      The sufficient.valid_keys?(requirements) do
        is true
      end

      The sufficient.validate_keys(requirements) do
        is nil
      end
    end

    The({}) do |empty|
      The empty.valid_keys?(requirements) do
        is true
      end

      The empty.validate_keys(requirements) do
        is nil
      end
    end

    The({a: nil}) do |shortage|
      The shortage.valid_keys?(requirements) do
        is false
      end

      CATCH KeyValidatable::InvalidKeysError do
        shortage.validate_keys(requirements)
      end
    end

    The({a: nil, b: nil}) do |excess|
      The excess.valid_keys?(requirements) do
        is false
      end

      CATCH KeyValidatable::InvalidKeysError do
        excess.validate_keys(requirements)
      end
    end
  end
end

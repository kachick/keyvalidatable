# coding: us-ascii
# frozen_string_literal: true

require_relative '../keyvalidatable'

module KeyValidatable
  module Refinements
    refine Hash do
      include KeyValidatable
    end

    refine Struct do
      include KeyValidatable
    end
  end
end

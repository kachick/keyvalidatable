# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

Declare.describe do
  The(Declare::VERSION) do |version|
    INSTANCE_OF String
    ok version.frozen?
    ok Gem::Version.correct?(version)
  end
end

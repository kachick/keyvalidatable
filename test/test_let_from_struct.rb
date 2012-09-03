require 'test/declare'
require_relative '../lib/keyvalidatable/core_ext'


requirements = {let: [:b]}

The(Struct.new(:a, :b, :c).new.valid_keys?(requirements)) do
  same false
end
  
The(Struct.new(:b).new) do |sufficient|
  The sufficient.valid_keys?(requirements) do
    same true
  end
  
  The sufficient.validate_keys(requirements) do
    same nil
  end
end

The(Struct.new(:a).new) do |shortage|
  The shortage.valid_keys?(requirements) do
    same false
  end
  
  CATCH KeyValidatable::InvalidKeysError do
    shortage.validate_keys(requirements)
  end
end

The(Struct.new(:a, :b).new) do |excess|
  The excess.valid_keys?(requirements) do
    same false
  end
  
  CATCH KeyValidatable::InvalidKeysError do
    excess.validate_keys(requirements)
  end
end

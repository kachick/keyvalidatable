require_relative '../lib/keyvalidatable'
require_relative 'helper'


requirements = {must: [:a, :c], let: [:b]}
  
The(KeyValidatable.valid_array?([:a, :b, :c], requirements)) do
  same true
end

The([:a, :c]) do |sufficient|
  The(KeyValidatable.valid_array?(sufficient, requirements)) do
    same true
  end
  
  The(KeyValidatable.validate_array(sufficient, requirements)) do
    same nil
  end
end

The([:a, :b]) do |shortage|
  The(KeyValidatable.valid_array?(shortage, requirements)) do
    same false
  end

  CATCH KeyValidatable::InvalidKeysError do
    KeyValidatable.validate_array(shortage, requirements)
  end
end


The([:a, :b, :c, :d]) do |excess|
  The(KeyValidatable.valid_array?(excess, requirements)) do
    same false
  end

  CATCH KeyValidatable::InvalidKeysError do
    KeyValidatable.validate_array(excess, requirements)
  end
end

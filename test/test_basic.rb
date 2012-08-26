require 'test/declare'
require_relative '../lib/keyvalidatable/core_ext'

requirements = {must: [:a, :c], let: [:b]}
  
The({a: nil, b: nil, c: nil}.valid_keys?(requirements)) do
  same true
end

The({a: nil, c: nil}) do |sufficient|
  The sufficient.valid_keys?(requirements) do
    same true
  end
  
  The sufficient.validate_keys(requirements) do
    same nil
  end
end

The({a: nil, b: nil}) do |shortage|
  The shortage.valid_keys?(requirements) do
    same false
  end
  
  CATCH KeyValidatable::InvalidKeysError do
    shortage.validate_keys(requirements)
  end
end

The({a: nil, b: nil, c: nil, d: nil}) do |excess|
  The excess.valid_keys?(requirements) do
    same false
  end
  
  CATCH KeyValidatable::InvalidKeysError do
    excess.validate_keys(requirements)
  end
end


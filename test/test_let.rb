require 'test/declare'
require_relative '../lib/keyvalidatable/core_ext'


requirements = {let: [:b]}

The({a: nil, b: nil, c: nil}.valid_keys?(requirements)) do
  same false
end
  
The({b: nil}) do |sufficient|
  The sufficient.valid_keys?(requirements) do
    same true
  end
  
  The sufficient.validate_keys(requirements) do
    same nil
  end
end

The({}) do |empty|
  The empty.valid_keys?(requirements) do
    same true
  end
  
  The empty.validate_keys(requirements) do
    same nil
  end
end

The({a: nil}) do |shortage|
  The shortage.valid_keys?(requirements) do
    same false
  end
  
  CATCH KeyValidatable::InvalidKeysError do
    shortage.validate_keys(requirements)
  end
end

The({a: nil, b: nil}) do |excess|
  The excess.valid_keys?(requirements) do
    same false
  end
  
  CATCH KeyValidatable::InvalidKeysError do
    excess.validate_keys(requirements)
  end
end

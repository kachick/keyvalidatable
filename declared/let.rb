$VERBOSE = true

require_relative '../lib/keyvalidatable'
require_relative '../lib/keyvalidatable/core_ext'
require 'declare'

Declare do

  requirements = {let: [:b]}
  
  The({a: nil, b: nil, c: nil}.valid_keys?(requirements)) do
    EQUAL false
  end
  
  The({b: nil}) do |sufficient|
    The sufficient.valid_keys?(requirements) do
      EQUAL true
    end
    
    The sufficient.validate_keys(requirements) do
      EQUAL nil
    end
  end
  
  The({a: nil}) do |shortage|
    The shortage.valid_keys?(requirements) do
      EQUAL false
    end
    
    CATCH KeyValidatable::InvalidKeysError do
      shortage.validate_keys(requirements)
    end
  end
  
  The({a: nil, b: nil}) do |excess|
    The excess.valid_keys?(requirements) do
      EQUAL false
    end
    
    CATCH KeyValidatable::InvalidKeysError do
      excess.validate_keys(requirements)
    end
  end

end

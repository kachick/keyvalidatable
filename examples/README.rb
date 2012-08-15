$VERBOSE = true

require_relative '../lib/keyvalidatable'
require_relative '../lib/keyvalidatable/core_ext'

class MyClass

  def my_method(options)
    options.validate_keys(must: [:a, :b], let: [:c])

    p "#{options} is valid"
  rescue
    p $!
  end

end

my_obj = MyClass.new
my_obj.my_method(a: 1, b: 2, c: 3)       #=> "{:a=>1, :b=>2, :c=>3} is valid"
my_obj.my_method(a: 1, c: 3)             #=> #<KeyValidatable::InvalidKeysError: Shortage: [:b] / Excess: []>
my_obj.my_method(a: 1, b: 2)             #=> "{:a=>1, :b=>2} is valid"
my_obj.my_method(a: 1, b: 2, c: 3, d: 4) #=> #<KeyValidatable::InvalidKeysError: Shortage: [] / Excess: [:d]>
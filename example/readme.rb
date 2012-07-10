$VERBOSE = true

require_relative '../lib/keyvalidatable'
require_relative '../lib/keyvalidatable/core_ext'

class MyClass

  def my_method(options)
    options.validate_keys(must: [:a, :b], let: [:c])

    "#{options} is valid"
  rescue
    "#{options} is invalid"
  end

end

my_obj = MyClass.new
p my_obj.my_method(a: 1, b: 2, c: 3)       #=> "{:a=>1, :b=>2, :c=>3} is valid"
p my_obj.my_method(a: 1, c: 3)             #=> "{:a=>1, :c=>3} is invalid"
p my_obj.my_method(a: 1, b: 2)             #=> "{:a=>1, :b=>2} is valid"
p my_obj.my_method(a: 1, b: 2, c: 3, d: 4) #=> "{:a=>1, :b=>2, :c=>3, :d=>4} is invalid"

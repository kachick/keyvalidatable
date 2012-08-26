keyvalidatable
==============

Description
-----------

Validate pair-object's key.

Features
--------

* Check option parameters are valid for a method.

Usage
-----

### Overview

```ruby
require 'keyvalidatable'
    
class MyClass

  def my_method(options)
    options.dup.extend(KeyValidatable).validate_keys(must: [:a, :b], let: [:c])

    p "#{options} is valid"
  rescue
    p $!
  end

end

my_obj = MyClass.new
my_obj.my_method(a: 1, b: 2, c: 3)       #=> "{:a=>1, :b=>2, :c=>3} is valid"
my_obj.my_method(a: 1, c: 3)             #=> InvalidKeysError: Shortage: [:b] / Excess: []
my_obj.my_method(a: 1, b: 2)             #=> "{:a=>1, :b=>2} is valid"
my_obj.my_method(a: 1, b: 2, c: 3, d: 4) #=> InvalidKeysError: Shortage: [] / Excess: [:d]
```

Requirements
------------

* Ruby 1.9.2 or later

  MRI/YARV, Rubinius, JRuby: http://travis-ci.org/#!/kachick/keyvalidatable

Install
-------

```shell
$ gem install keyvalidatable
```

Link
----

* code: https://github.com/kachick/keyvalidatable
* issues: https://github.com/kachick/keyvalidatable/issues
* CI: http://travis-ci.org/#!/kachick/keyvalidatable
* gem: https://rubygems.org/gems/keyvalidatable
* gem+: http://metagem.info/gems/keyvalidatable

License
-------

The MIT X License

Copyright (c) 2012 Kenichi Kamiya

See the file LICENSE for further details.

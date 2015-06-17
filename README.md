keyvalidatable
==============

Description
-----------

Validate shortage/excess keys in pairs.

Usage
-----

### Validate option parameters(hash-argument)

```ruby
require 'keyvalidatable'
    
class Foo

  def func(options)
    KeyValidatable.validate_keys options, must: [:a, :b], let: [:c]

    p "#{options} is valid"
  rescue
    p $!
  end

end

foo = Foo.new
foo.func(a: 1, b: 2, c: 3)       #=> "{:a=>1, :b=>2, :c=>3} is valid"
foo.func(a: 1, c: 3)             #=> InvalidKeysError: Shortage: [:b] / Excess: []
foo.func(a: 1, b: 2)             #=> "{:a=>1, :b=>2} is valid"
foo.func(a: 1, b: 2, c: 3, d: 4) #=> InvalidKeysError: Shortage: [] / Excess: [:d]
```

Requirements
------------

* Ruby - [1.9.3 or later](http://travis-ci.org/#!/kachick/keyvalidatable)

Install
-------

```shell
$ gem install keyvalidatable
```

Build Status
-------------

[![Build Status](https://secure.travis-ci.org/kachick/keyvalidatable.png)](http://travis-ci.org/kachick/keyvalidatable)

Link
----

* [code](https://github.com/kachick/keyvalidatable)
* [API](http://kachick.github.com/keyvalidatable/yard/frames.html)
* [issues](https://github.com/kachick/keyvalidatable/issues)
* [CI](http://travis-ci.org/#!/kachick/keyvalidatable)
* [gem](https://rubygems.org/gems/keyvalidatable)

License
-------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.

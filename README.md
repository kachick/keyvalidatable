keyvalidatable
==============

[![Build Status](https://secure.travis-ci.org/kachick/keyvalidatable.png)](http://travis-ci.org/kachick/keyvalidatable)

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
    
class Foo

  def func(options)
    options.dup.extend(KeyValidatable).validate_keys(must: [:a, :b], let: [:c])

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

* Ruby - [1.9.2 or later](http://travis-ci.org/#!/kachick/keyvalidatable)

Install
-------

```shell
$ gem install keyvalidatable
```

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
See the file LICENSE for further details.

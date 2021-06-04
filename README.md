# keyvalidatable

* ***This repository is archived***
* ***No longer maintained***
* ***If someone want to use this namespace to publish new awesome gem, please [contact me](https://github.com/kachick/times_kachick/discussions/new)!***

![Build Status](https://github.com/kachick/keyvalidatable/actions/workflows/test_behaviors.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/keyvalidatable.png)](http://badge.fury.io/rb/keyvalidatable)

Validate shortage/excess keys in pairs.

## Usage

### Install

Require Ruby 2.5 or later
(Last tested rubies are 3.0.1 and 3.1.0dev)

Add this line to your`Gemfile`

```ruby
gem 'keyvalidatable', '>= 0.2.1', '< 0.3.0'
```

### Overview

```ruby
require 'keyvalidatable'

class Foo
  def func(options)
    KeyValidatable.validate_keys options, must: [:a, :b], let: [:c]

    p "#{options} is valid"
  rescue => err
    p err
  end
end

foo = Foo.new
foo.func(a: 1, b: 2, c: 3)       #=> "{:a=>1, :b=>2, :c=>3} is valid"
foo.func(a: 1, c: 3)             #=> InvalidKeysError: Shortage: [:b] / Excess: []
foo.func(a: 1, b: 2)             #=> "{:a=>1, :b=>2} is valid"
foo.func(a: 1, b: 2, c: 3, d: 4) #=> InvalidKeysError: Shortage: [] / Excess: [:d]
```

## Links

* [Repository](https://github.com/kachick/keyvalidatable)
* [API documents](https://kachick.github.io/keyvalidatable)

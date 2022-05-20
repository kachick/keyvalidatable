# keyvalidatable

* ***This repository is archived***
* ***No longer maintained***
* ***All versions have been yanked from https://rubygems.org for releasing valuable namespace for others***

![Build Status](https://github.com/kachick/keyvalidatable/actions/workflows/test_behaviors.yml/badge.svg?branch=main)

Validate shortage/excess keys in pairs.

## Usage

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

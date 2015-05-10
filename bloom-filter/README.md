Bloom filter
============

A toy implementation of
[Bloom filter](http://en.wikipedia.org/wiki/Bloom_filter)
with trivial hash functions.

## Usage

Install bitarray first:

```console
$ gem install bitarray
```

Then try it out:

```ruby
require "./bloom-filter"
filter = BloomFilter.new(1000)
filter.get "stuff" # => false
filter.put "stuff" # => [553, 120, 115], bit positions set
filter.get "stuff" # => true
filter.clear!
filter.get "stuff" # => false
```

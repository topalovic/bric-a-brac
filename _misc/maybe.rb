# A very basic implementation of the Maybe monad.

require 'singleton'

class Some
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def bind(blk = nil)
    return blk.(value) if blk
    yield value
  end
  alias_method :-, :bind

  def fmap
    Maybe(yield value)
  end
end

class None
  include Singleton

  def value; nil end
  def bind(*); self end
  def fmap; self end
  alias_method :-, :bind
end

def Maybe(value)
  value ? Some(value) : None()
end

def Some(value)
  Some.new(value)
end

def None()
  None.instance
end

# Usage:

p Maybe(1).bind { |x| Maybe(x + 1) }.bind { |x| Maybe(x + 1) }
#=> Some(3)

# DSL-y:

p Maybe(1) --> x {
    Maybe(x + 1) } --> x {
      Maybe(x + 1) }
#=> Some(3)

inc = ->(x) { Maybe(x + 1) }

p Maybe(2).bind(&inc).bind(&inc)   #=> Some(4)
p Maybe(nil).bind(&inc).bind(&inc) #=> None()

p Maybe(-1).fmap(&:abs).fmap(&:succ).value  #=> 2
p Maybe(nil).fmap(&:abs).fmap(&:succ).value #=> nil

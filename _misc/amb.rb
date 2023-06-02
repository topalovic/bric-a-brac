# frozen_string_literal: true

# See http://www.randomhacks.net/2005/10/11/amb-operator/
#
# There is also a gem: https://github.com/chikamichi/amb

require 'continuation'

# A list of places we can "rewind" to if we encounter amb with no arguments.
$backtrack_points = []

# Rewind to our most recent backtrack point.
def backtrack
  raise "Can't backtrack" if $backtrack_points.empty?

  $backtrack_points.pop.call
end

# Recursive implementation of the amb operator.
def amb(*choices)
  # Fail if no arguments.
  backtrack if choices.empty?

  callcc do |cc|
    # cc contains the current continuation.
    # When called, it will make the program rewind to the end of this block.
    $backtrack_points.push cc

    # Return our first argument.
    return choices[0]
  end

  # We only get here if we backtrack using the stored value of cc, above.
  # We call amb recursively with the arguments we didn't use.
  amb(*choices.drop(1))
end

# Backtracking beyond a call to cut is strictly forbidden.
def cut
  $backtrack_points = []
end

# Ex: https://en.wikipedia.org/wiki/Change-making_problem

coinset = [3, 5, 7]
target = 37

res = coinset.map { |c| [c, amb(*0.upto(target / c))] }.to_h
sum = res.reduce(0) { |r, (k, v)| r + k * v }

print 'trying: '
p res

amb unless sum == target
cut

print 'SOLVED: '
p res #=> {3=>0, 5=>6, 7=>1}

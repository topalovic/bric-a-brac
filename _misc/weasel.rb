# See https://en.wikipedia.org/wiki/Weasel_program

DICT = ('A'..'Z').to_a << ' '
TARGET = 'A monkey hitting keys at random for an infinite amount of time will almost surely type the complete works of William Shakespeare'.upcase
GEN_SIZE = 100
RATE = 0.01

specimen = (ARGV.join(' ').upcase.ljust(TARGET.size))[0...TARGET.size]
specimen = Array.new(TARGET.size) { DICT.sample }.join if specimen.strip.empty?

def mutate(specimen)
  specimen.chars.map { |c| rand < RATE ? DICT.sample : c }.join
end

def fitness(specimen)
  specimen.chars.zip(TARGET.chars).count { |i, j| i == j } * 100.0 / TARGET.size
end

def log(iter, specimen)
  puts "%4d %.2f%%\t%s" % [iter, fitness(specimen), specimen]
end

i = 0
parent = nil

while specimen != TARGET
  i += 1
  log(i, specimen) unless specimen == parent
  parent = specimen
  generation = GEN_SIZE.times.map { mutate(specimen) } << specimen
  specimen = generation.max_by(&method(:fitness))
end

log(i, specimen)

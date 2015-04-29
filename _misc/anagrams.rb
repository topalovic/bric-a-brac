# Design a function that returns all the anagrams for a given word.

class String

  DICT_PATHS = %w[/usr/dict/words /usr/share/dict/words]
  DICT = DICT_PATHS.find { |f| File.exist? f }

  def anagram?(w)
    return false unless size == w.size
    split("").sort == w.split("").sort
  end

  def anagrams
    IO.foreach(DICT).select { |w| anagram? w.chomp }.map(&:chomp)
  end
end

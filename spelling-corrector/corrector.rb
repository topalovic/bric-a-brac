def train(features)
  features.reduce(Hash.new 1) { |f, w| f[w] += 1; f }
end

NWORDS = train(File.read("big.txt").downcase.scan /[a-z]+/)

def edits1(word)
  splits     = (0..word.size).map  { |i| [word[0...i], word[i..-1]] }
  deletes    = splits[1..-1].map   { |a, b| a.chop + b }
  transposes = splits[0..-3].map   { |a, b| a + b[1] + b[0] + b[2..-1] }
  replaces   = ("a".."z").flat_map { |c| splits[0..-2].map { |a, b| a + c + b[1..-1] }}
  inserts    = ("a".."z").flat_map { |c| splits.map { |a, b| a + c + b }}
  deletes + transposes + replaces + inserts
end

def known_edits2(word)
  res = edits1(word).flat_map { |e1| edits1(e1) } & NWORDS.keys
  res.any? && res
end

def known(words)
  (words & NWORDS.keys).tap { |r| return nil if r.empty? }
end

def correct(word)
  (known([word]) || known(edits1(word)) || known_edits2(word) || [word]).sort_by { |w| -NWORDS[w] }
end

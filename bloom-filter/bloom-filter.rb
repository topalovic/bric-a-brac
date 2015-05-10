require "bitarray"

class BloomFilter

  def initialize(m)
    @bits = BitArray.new(m)
    @hashes = %i[+ * ^].map { |op| gen_hash op }
  end

  def put(key)
    @hashes
      .map { |h| h.call key }
      .tap { |_bits| _bits.each { |b| @bits[b] = 1 } }
  end

  def get(key)
    @hashes.all? { |h| @bits[h.call key] == 1 }
  end

  def clear!
    @bits = BitArray.new(@bits.size)
    true
  end

  private

  def gen_hash(op)
    ->(key) {
      key.each_byte.reduce(1) { |acc, b|
        acc.send(op, b)
      } % @bits.size
    }
  end
end

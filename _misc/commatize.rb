# Design a function that returns a decimal representation
# of a given number grouped by commas after every 3 digits.

# 1 => "1"
# 100 => "100"
# 10000 => "10,000"
# 1000000 => "1,000,000"
# 1234567890 => "1,234,567,890"
# -1234567890 => "-1,234,567,890"

class Fixnum
  def commatize(n = 3)
    abs.to_s
      .reverse
      .scan(/.{1,#{n}}/)
      .join(",")
      .reverse
      .tap { |s| s.prepend("-") if self < 0 }
  end

  def fast_commatize(n = 3)
    dividend, divisor = abs, 10 ** n
    res = []

    while !dividend.zero? do
      dividend, mod = dividend.divmod(divisor)
      group = dividend.zero? ? mod.to_s : mod.to_s.rjust(n, "0")
      res.unshift(group)
    end

    res.join(",").tap do |s|
      s.prepend("-") if self < 0
    end
  end
end

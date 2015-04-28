module Levenshtein

  # Calculate Levenshtein distance between given strings.
  # (http://en.wikipedia.org/wiki/Levenshtein_distance#Iterative_with_two_matrix_rows)
  #
  # @param s1 [String]
  # @param s2 [String]
  # @param debug [Boolean] when true, prints the matrix to visualize the algorithm
  #
  # @return [Fixnum] distance
  def self.distance(s1, s2, debug: false)
    return 0 if s1 == s2

    l1, l2 = s1.size, s2.size
    return l1 if l2 == 0
    return l2 if l1 == 0

    row = 0.upto(l1).to_a
    dist = nil

    if debug
      puts s1.split("").join(" ").prepend("    ")
      puts row.join(" ").prepend("  ")
    end

    s2.each_char.with_index(1) do |c2, i|
      s1.each_char.with_index do |c1, j|
        cost = (c1 == c2) ? 0 : 1
        insert_cost = row[j + 1] + 1
        delete_cost = i + 1
        substitute_cost = row[j] + cost

        dist = [
          insert_cost,
          delete_cost,
          substitute_cost
        ].min

        row[j], i = i, dist
      end

      row[l1] = dist

      puts row.join(" ").prepend("#{c2} ") if debug
    end

    dist
  end
end

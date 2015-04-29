# Design a function that returns all the leaves of a given tree.
#
# My take:
#
# Given that tree is represented as a nested Hash, with other
# types allowed to represent leaves.

class Hash
  def leaves
    reduce([]) do |r, (k, v)|
      r | Array(
        case v
        when nil, {}, [] then k
        when Hash then v.leaves
        else v
        end
      )
    end
  end
end

# tree = {
#   1 => {
#     2 => 3,
#     4 => [5, 6]
#   },
#   7 => {
#     8 => {
#       9 => 10
#     },
#     11 => nil,
#     12 => {},
#     13 => []
#   },
#   [14] => nil
# }
#
# tree.leaves
# => [3, 5, 6, 10, 11, 12, 13, 14]

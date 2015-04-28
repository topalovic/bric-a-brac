Levenshtein distance
====================

Levenshtein distance,
[iterative implementation](http://en.wikipedia.org/wiki/Levenshtein_distance#Iterative_with_two_matrix_rows).

## Usage

```ruby
> require "./levenshtein"
> Levenshtein.distance "Saturday", "Sunday"
# => 3
> Levenshtein.distance "Saturday", "Sunday", debug: true
#     S a t u r d a y
#   0 1 2 3 4 5 6 7 8
# S 1 0 1 2 3 4 5 6 7
# u 2 1 1 2 2 3 4 5 6
# n 3 2 2 2 3 3 4 5 6
# d 4 3 3 3 3 4 3 4 5
# a 5 4 3 4 4 4 4 3 4
# y 6 5 4 4 5 5 5 4 3
# => 3
```

def qsort(col)
  return [] if col.empty?
  pivot = col.slice!(rand col.size)
  less, more = col.partition { |n| n < pivot }
  qsort(less) + [pivot] + qsort(more)
end

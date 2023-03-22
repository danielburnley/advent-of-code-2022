require_relative '../helpers'

input = get_input_for_day(day: 4).map { |l| l.split(",").map { |s| s.split("-").map(&:to_i) } }
# part one
res = input.select do |a, b|
  first = (a[0]..a[1]).to_a
  second = (b[0]..b[1]).to_a
  intersect = first & second
  intersect == first or intersect == second
end.count
puts res

res = input.select do |a, b|
  first = (a[0]..a[1]).to_a
  second = (b[0]..b[1]).to_a
  intersect = first & second
  intersect.length > 0
end.count
puts res

require_relative '../helpers'

def to_priority(char)
  if char.ord < 97
    return char.ord - 64 + 26
  end
  return char.ord - 96
end

input = get_input_for_day(day: 3)
puts input.map { |line| [line[0..line.length/2],line[line.length/2..-1]] }.map { |a,b| a.chars.intersection(b.chars)[0] }.map { |l| to_priority(l) }.sum
puts input.each_slice(3).map { |a,b,c| a.chars & b.chars & c.chars }.map { |l| to_priority(l[0]) }.sum

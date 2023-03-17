require_relative '../helpers'

input = get_input_for_day(day: 3)
puts input.map { |line| [line[0..line.length/2],line[line.length/2..-1]] }.map { |a,b| a.chars.intersection(b.chars)[0] }.map { |l| (('a'..'z').to_a + ('A'..'Z').to_a).index(l)+1 }.sum
puts input.each_slice(3).map { |a,b,c| a.chars & b.chars & c.chars }.map { |l| (('a'..'z').to_a + ('A'..'Z').to_a).index(l[0])+1 }.sum

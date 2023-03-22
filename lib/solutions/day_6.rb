require_relative '../helpers'

input = get_input_for_day(day: 6)[0].chars

i = 3
while i < input.length
  segment = input[i-3..i]
  if segment.uniq == segment
    puts "Part one: #{i + 1}"
    break
  end
  i += 1
end

i = 13
while i < input.length
  segment = input[i-13..i]
  if segment.uniq == segment
    puts "Part two: #{i + 1}"
    break
  end
  i += 1
end

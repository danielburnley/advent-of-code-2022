require_relative '../helpers'

input = get_example_input_for_day(day: 5)

def get_starting_state(input)
  rows = []
  input.each do |line|
    break unless line.include?("[")
    line.chars.each_slice(4).with_index do |cargo, i|
      if rows[i]
        rows[i] << cargo[1] 
      else
        rows[i] = [cargo[1]]
      end
    end
  end
  rows.map { |r| r.select { |c| c.strip.length > 0 } } 
end

def get_instructions(input)
  input[input.index("") + 1..-1]
end

cargo = get_starting_state(input)
instructions = get_instructions(input)
instructions.each do |instruction|
  matches = instruction.match(/move ([0-9]+) from ([0-9]+) to ([0-9]+)/)
  count = matches[1].to_i
  from = matches[2].to_i - 1
  to = matches[3].to_i - 1
  in_transit = cargo[from][0..count-1]
  cargo[from] = cargo[from][count..-1]
  cargo[to] = in_transit.reverse + cargo[to]
end
puts "Part one: #{cargo.map {|c| c[0]}.join("")}"

cargo = get_starting_state(input)
instructions = get_instructions(input)
instructions.each do |instruction|
  matches = instruction.match(/move ([0-9]+) from ([0-9]+) to ([0-9]+)/)
  count = matches[1].to_i
  from = matches[2].to_i - 1
  to = matches[3].to_i - 1
  in_transit = cargo[from][0..count-1]
  cargo[from] = cargo[from][count..-1] || []
  cargo[to] = in_transit + cargo[to]
end

puts "Part two: #{cargo.map {|c| c[0]}.join("")}"

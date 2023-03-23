require_relative '../helpers'

# For a 2D Grid that is fully populated
class SimpleGrid
  attr_reader :grid

  def initialize(input)
    @grid = input
  end

  def rows
    grid
  end

  def columns
    columns = []
    rows.each do |row|
      row.each.with_index do |cell, i|
        if columns[i]
          columns[i] << cell
        else
          columns[i] = [cell]
        end
      end
    end
    columns
  end
end

input = get_example_input_for_day(day: 8).map { |l| l.chars.map(&:to_i) }
grid = CoordinateGrid.new(input)
simple_grid = SimpleGrid.new(input)
p simple_grid.rows
p simple_grid.columns

count = 0

grid.all_positions.each do |x,y|
  p "#{x},#{y}"
  column = grid.column(x)
  row = grid.row(y)
  tree_height = grid.get(x,y)

  if x == 0 or y == 0
    count += 1
    next
  end

  if x == grid.size[:x] - 1 or y == grid.size[:y] - 1
    count += 1
    next
  end

  up = column[0..y-1]
  down = column[y+1..-1]
  left = row[0..x-1]
  right = row[x+1..-1]
  to_check = [left, right, up, down]
  to_check.each do |check|
    if check.all? { |c| c < tree_height }
      count += 1
      break
    end
  end
end

p count

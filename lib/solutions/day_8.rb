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

input = get_input_for_day(day: 8).map { |l| l.chars.map(&:to_i) }
grid = SimpleGrid.new(input)
visible = []

def get_visible(trees)
  max_height_seen = -1
  visible_trees = []
  trees.each do |tree|
    if tree > max_height_seen
      visible_trees << true
      max_height_seen = tree
    else
      visible_trees << false
    end
  end
  visible_trees
end
# Part one
grid.rows.each.with_index do |row, y|
  # Left to right
  get_visible(row).each.with_index do |tree_visible,x|
    visible << [x,y] if tree_visible
  end

  # Right to left
  get_visible(row.reverse).reverse.each.with_index do |tree_visible,x|
    visible << [x,y] if tree_visible
  end
end

grid.columns.each.with_index do |col, x|
  # Top to bottom
  get_visible(col).each.with_index do |tree_visible,y|
    visible << [x,y] if tree_visible
  end

  # Bottom to top
  get_visible(col.reverse).reverse.each.with_index do |tree_visible,y|
    visible << [x,y] if tree_visible
  end
end

puts "Part one: #{visible.uniq.length}"

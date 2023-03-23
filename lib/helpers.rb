require_relative 'solution_fetcher'

class CoordinateGrid
  attr_reader :grid

  def initialize(input)
    @grid = {}
    input.each_with_index do |line, y|
      line.each_with_index do |val, x|
        @grid[y] = {} unless @grid[y]

        @grid[y][x] = val
      end
    end
  end

  def get(x, y)
    return grid[y][x] if grid[y]

    nil
  end

  def size
    x = grid.sort.map { |row| row[1].sort.length }.max
    y = grid.sort.length
    {x: x, y: y}
  end

  def set(x, y, value)
    grid[y][x] = value if grid[y]
  end

  def print
    to_print = grid.sort.map do |row|
      row[1].sort.map { |x| x[1] }.join(',')
    end.join("\n")
    puts to_print
  end

  def adjacent_values(x, y, include_diagonal = false)
    adjacent_positions(x, y, include_diagonal).map { |p| get(p[0], p[1]) }
  end

  def adjacent_positions(x, y, include_diagonal = false)
    positions = [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]]
    positions += [[x - 1, y - 1], [x + 1, y - 1], [x - 1, y + 1], [x + 1, y + 1]] if include_diagonal
    positions.select { |p| get(p[0], p[1]) }
  end

  def adjacent_positions_and_values(x, y, include_diagonal = false)
    positions = adjacent_positions(x, y, include_diagonal)
    positions.map do |pos|
      {
        pos: pos,
        val: get(pos[0], pos[1])
      }
    end
  end

  def all_positions
    res = []

    grid.each do |y, rows|
      rows.each do |x, _|
        res << [x, y]
      end
    end

    res
  end

  def all_values
    grid.values.reduce([]) do |res, line|
      res + line.values
    end
  end

  def row(y)
    grid[y].sort.map { |row| row[1] }
  end

  def rows
    grid.sort.map { |row| row[1].sort.map { |c| c[1] } }
  end

  def column(x)
    grid.sort.map { |row| row[1][x] }
  end
end

def get_example_input_for_day(day:)
  File.open("#{__dir__}/inputs/day_#{day}_example.txt", 'r') { |f| f.readlines(chomp: true) }
end

def get_input_for_day(day:)
  File.open("#{__dir__}/inputs/day_#{day}.txt", 'r') { |f| f.readlines(chomp: true) }
rescue StandardError
  puzzle_input = fetch_solution_for_day(day: day)

  File.open("#{__dir__}/inputs/day_#{day}.txt", 'w') do |f|
    f.write(puzzle_input)
  end

  File.open("#{__dir__}/inputs/day_#{day}.txt", 'r') { |f| f.readlines(chomp: true) }
end

def print_hash_coords(coords)
  max_y = coords.keys.max
  max_x = coords.values.map { |line| line.keys }.flatten.max
  lines = []
  (0..max_y).each do |y|
    line = []
    if coords[y]
      (0..max_x).each do |x|
        line << (coords[y][x] || '.')
      end
    else
      (0..max_x).each { |_| line << '.' }
    end

    lines << line.join('')
  end

  puts lines.join("\n")
end

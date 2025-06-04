# frozen_string_literal: true

# Board objects represent the state of the connect four board
class Board
  attr_reader :grid

  def initialize(grid = Array.new(6) { Array.new(7, '⚫') })
    @grid = grid
  end

  def to_s
    output_str = "C1 C2 C3 C4 C5 C6 C7\n"
    grid.each { |row| output_str += "#{row.join(' ')}\n" }
    output_str
  end
end

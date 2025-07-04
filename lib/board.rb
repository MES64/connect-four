# frozen_string_literal: true

# Board objects represent the state of the connect four board
class Board
  attr_reader :grid

  def initialize(grid = Array.new(6) { Array.new(7, '⚫') })
    @grid = grid
  end

  def four_in_row?(token)
    four_in_rows?(token) ||
      four_in_columns?(token) ||
      four_in_forward_slash_diagonals?(token) ||
      four_in_backslash_diagonals?(token)
  end

  def full?
    grid.flatten.none? { |token| token == '⚫' }
  end

  def valid_move?(column)
    return false if column.negative?

    grid[0][column] == '⚫'
  end

  def place_token(token, column)
    return if column.negative?

    row = -1
    row += 1 while grid.dig(row + 1, column) == '⚫'
    return if row.negative?

    grid[row][column] = token
  end

  def to_s
    output_str = "C1 C2 C3 C4 C5 C6 C7\n"
    grid.each { |row| output_str += "#{row.join(' ')}\n" }
    output_str
  end

  private

  def four_in_rows?(token)
    grid.any? { |row| row.join.include?(token * 4) }
  end

  def four_in_columns?(token)
    grid.transpose.any? { |column| column.join.include?(token * 4) }
  end

  def four_in_forward_slash_diagonals?(token)
    forward_slash_diagonals.any? { |diagonal| diagonal.join.include?(token * 4) }
  end

  def four_in_backslash_diagonals?(token)
    backslash_diagonals.any? { |diagonal| diagonal.join.include?(token * 4) }
  end

  def forward_slash_diagonals
    align_forward_slash_diagonals_on_columns_and_transpose_for_diagonal_per_row(grid)
  end

  def backslash_diagonals
    align_forward_slash_diagonals_on_columns_and_transpose_for_diagonal_per_row(grid.reverse)
  end

  def align_forward_slash_diagonals_on_columns_and_transpose_for_diagonal_per_row(input_grid)
    input_grid.map.each_with_index do |row, index|
      shift_row_to_align_diagonals_and_pad_to_allow_transpose(row, index, input_grid.length - 1)
    end.transpose
  end

  def shift_row_to_align_diagonals_and_pad_to_allow_transpose(row, index, max_index)
    Array.new(index, '⚫').concat(row, Array.new(max_index - index, '⚫'))
  end
end

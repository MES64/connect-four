# frozen_string_literal: true

# Game objects represent the state of the connect four game
class Game
  attr_reader :board

  def initialize(board:)
    @board = board
  end

  def result
    red_four = board.four_in_row?('🔴')
    blue_four = board.four_in_row?('🔵')
    return 'Unknown' if red_four && blue_four
    return "#{red_four ? '🔴' : '🔵'} Wins!" if red_four || blue_four

    'Draw!' if board.full?
  end

  def make_move
    loop do
      return if board.valid_move?(0)

      puts 'Invalid Input!'
    end
  end
end

# frozen_string_literal: true

# Game objects represent the state of the connect four game
class Game
  attr_reader :board, :current_token

  def initialize(board:)
    @board = board
    @current_token = '🔵'
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
      puts 'Enter an unblocked column 1-7'
      column = user_input_column
      return board.place_token(current_token, column) if board.valid_move?(column)

      puts 'Invalid Input!'
    end
  end

  def user_input_column
    gets.to_i - 1
  end
end

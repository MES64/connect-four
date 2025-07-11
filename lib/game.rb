# frozen_string_literal: true

require_relative 'board'

# Game objects represent the state of the connect four game
class Game
  attr_accessor :current_token
  attr_reader :board

  def initialize(board: Board.new, current_token: '🔵')
    @board = board
    @current_token = current_token
  end

  def play
    puts 'Welcome to Connect Four! Please choose who goes first and start play...'
    loop do
      puts board
      puts
      current_result = result
      return puts current_result if current_result

      puts current_token
      make_move
      switch_token
    end
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

  def switch_token
    self.current_token = current_token == '🔵' ? '🔴' : '🔵'
  end
end

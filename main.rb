# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/board'

board = Board.new
game = Game.new(board:)

puts game.board
7.times do
  game.make_move
  puts game.board
end

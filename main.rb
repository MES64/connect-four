# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/board'

board = Board.new
Game.new(board:).play

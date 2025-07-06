# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

RSpec.describe Game do
  describe '#result' do
    # Incoming Query Message -> Test value returned

    let(:board) { instance_double(Board) }
    subject(:game_result) { described_class.new(board:) }

    context 'when the board is not full' do
      before do
        allow(board).to receive(:full?).and_return(false)
      end

      context 'when the board has no winner' do
        before do
          allow(board).to receive(:four_in_row?).and_return(false)
        end

        it 'the result of Game is nil' do
          result = game_result.result
          expect(result).to be_nil
        end
      end

      context 'when the board has only red as the winner' do
        before do
          allow(board).to receive(:four_in_row?).with('🔴').and_return(true)
          allow(board).to receive(:four_in_row?).with('🔵').and_return(false)
        end

        it 'the result of Game is "🔴 Wins!"' do
          result = game_result.result
          expect(result).to eql('🔴 Wins!')
        end
      end

      context 'when the board has only blue as the winner' do
        before do
          allow(board).to receive(:four_in_row?).with('🔴').and_return(false)
          allow(board).to receive(:four_in_row?).with('🔵').and_return(true)
        end

        it 'the result of Game is "🔵 Wins!"' do
          result = game_result.result
          expect(result).to eql('🔵 Wins!')
        end
      end

      context 'when the board has both as winners' do
        before do
          allow(board).to receive(:four_in_row?).with('🔴').and_return(true)
          allow(board).to receive(:four_in_row?).with('🔵').and_return(true)
        end

        it 'the result of Game is "Unknown"' do
          result = game_result.result
          expect(result).to eql('Unknown')
        end
      end
    end

    context 'when the board is full' do
      before do
        allow(board).to receive(:full?).and_return(true)
      end

      context 'when the board has no winner' do
        before do
          allow(board).to receive(:four_in_row?).and_return(false)
        end

        it 'the result of Game is "Draw!"' do
          result = game_result.result
          expect(result).to eql('Draw!')
        end
      end

      context 'when the board has only red as the winner' do
        before do
          allow(board).to receive(:four_in_row?).with('🔴').and_return(true)
          allow(board).to receive(:four_in_row?).with('🔵').and_return(false)
        end

        it 'the result of Game is "🔴 Wins!"' do
          result = game_result.result
          expect(result).to eql('🔴 Wins!')
        end
      end

      context 'when the board has only blue as the winner' do
        before do
          allow(board).to receive(:four_in_row?).with('🔴').and_return(false)
          allow(board).to receive(:four_in_row?).with('🔵').and_return(true)
        end

        it 'the result of Game is "🔵 Wins!"' do
          result = game_result.result
          expect(result).to eql('🔵 Wins!')
        end
      end

      context 'when the board has both as winners' do
        before do
          allow(board).to receive(:four_in_row?).with('🔴').and_return(true)
          allow(board).to receive(:four_in_row?).with('🔵').and_return(true)
        end

        it 'the result of Game is "Unknown"' do
          result = game_result.result
          expect(result).to eql('Unknown')
        end
      end
    end
  end

  describe '#make_move' do
    # Looping Script -> Test behavior
    # The user inputs until the move is valid with puts and gets, then places the token
    # This gives it multiple responsibility, as it sends command messages to both standard
    # output and the Board object that are well tested, and hence is a type of script method
    # that loops.

    let(:board) { instance_double(Board) }
    subject(:game_move) { described_class.new(board:) }

    before do
      allow(board).to receive(:place_token)
      allow(game_move).to receive(:puts)
      allow(game_move).to receive(:gets)
    end

    context 'when the input is valid' do
      before do
        allow(board).to receive(:valid_move?).and_return(true)
      end

      it 'does not show the invalid input message' do
        expect(game_move).to_not receive(:puts).with('Invalid Input!')
        game_move.make_move
      end
    end

    context 'when the input is invalid, then valid' do
      before do
        allow(board).to receive(:valid_move?).and_return(false, true)
      end

      it 'shows the invalid input message exactly once' do
        expect(game_move).to receive(:puts).with('Invalid Input!').exactly(1).time
        game_move.make_move
      end
    end

    context 'when the input is invalid four times in a row, then valid' do
      before do
        allow(board).to receive(:valid_move?).and_return(false, false, false, false, true)
      end

      it 'shows the invalid input message exactly four times' do
        expect(game_move).to receive(:puts).with('Invalid Input!').exactly(4).times
        game_move.make_move
      end
    end
  end
end

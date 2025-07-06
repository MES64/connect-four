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
end

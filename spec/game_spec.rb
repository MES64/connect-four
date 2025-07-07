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
      allow(game_move).to receive(:user_input_column)
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

  describe '#user_input_column' do
    # Incoming Query Message -> Test value returned

    let(:board) { instance_double(Board) }
    subject(:game_input) { described_class.new(board:) }

    context 'when the user inputs "1"' do
      before do
        allow(game_input).to receive(:gets).and_return('1\n')
      end

      it 'returns integer 0' do
        expect(game_input.user_input_column).to eql(0)
      end
    end

    context 'when the user inputs "2"' do
      before do
        allow(game_input).to receive(:gets).and_return('2\n')
      end

      it 'returns integer 1' do
        expect(game_input.user_input_column).to eql(1)
      end
    end

    context 'when the user inputs "-1"' do
      before do
        allow(game_input).to receive(:gets).and_return('-1\n')
      end

      it 'returns integer -2' do
        expect(game_input.user_input_column).to eql(-2)
      end
    end

    context 'when the user inputs non-numeric characters at end: "7h"' do
      before do
        allow(game_input).to receive(:gets).and_return('7h\n')
      end

      it 'ignores them and returns integer 6' do
        expect(game_input.user_input_column).to eql(6)
      end
    end

    context 'when the user inputs non-numeric characters at start: "h7"' do
      before do
        allow(game_input).to receive(:gets).and_return('h7\n')
      end

      it 'returns integer -1' do
        expect(game_input.user_input_column).to eql(-1)
      end
    end

    context 'when the user does not enter any numeric characters: ""' do
      before do
        allow(game_input).to receive(:gets).and_return('\n')
      end

      it 'returns integer -1' do
        expect(game_input.user_input_column).to eql(-1)
      end
    end
  end

  describe '#switch_token' do
    # Incoming Command Message -> Test change in observable state

    let(:board) { instance_double(Board) }

    context 'when the current token is "🔵"' do
      subject(:game_switch_blue) { described_class.new(board:, current_token: '🔵') }

      it 'sets the current token to "🔴"' do
        game_switch_blue.switch_token
        current_token = game_switch_blue.current_token
        expect(current_token).to eql('🔴')
      end
    end

    context 'when the current token is "🔴"' do
      subject(:game_switch_red) { described_class.new(board:, current_token: '🔴') }

      it 'sets the current token to "🔵"' do
        game_switch_red.switch_token
        current_token = game_switch_red.current_token
        expect(current_token).to eql('🔵')
      end
    end
  end

  describe '#play' do
    # Looping Script -> Test the behavior
    # Loop until the result is set (not nil)

    let(:board) { instance_double(Board) }
    subject(:game_play) { described_class.new(board:) }

    before do
      allow(game_play).to receive(:puts)
      allow(game_play).to receive(:make_move)
      allow(game_play).to receive(:switch_token)
    end

    context 'when the result is set from the start' do
      before do
        allow(game_play).to receive(:result).and_return('🔴 Wins!')
      end

      it 'returns immediately and does not send the #make_move message' do
        expect(game_play).to_not receive(:make_move)
        game_play.play
      end
    end

    context 'when the result is nil once, then set' do
      before do
        allow(game_play).to receive(:result).and_return(nil, '🔵 Wins!')
      end

      it 'sends the #make_move message exactly once' do
        expect(game_play).to receive(:make_move).exactly(1).time
        game_play.play
      end
    end

    context 'when the result is nil four times, then set' do
      before do
        allow(game_play).to receive(:result).and_return(nil, nil, nil, nil, 'Draw!')
      end

      it 'sends the #make_move message exactly four times' do
        expect(game_play).to receive(:make_move).exactly(4).times
        game_play.play
      end
    end
  end
end

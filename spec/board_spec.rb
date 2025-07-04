# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  describe '#to_s' do
    # Incoming Query Message -> Check return value

    context 'when the grid is empty' do
      subject(:board_string_empty) { described_class.new }
      it 'returns string version of empty grid' do
        expected_string = <<~TEXT
          C1 C2 C3 C4 C5 C6 C7
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
        TEXT
        actual_string = board_string_empty.to_s
        expect(actual_string).to eql(expected_string)
      end
    end

    context 'when the grid is normal: non-empty and non-full with a mixture of colored disks' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_string_normal) { described_class.new(normal_grid) }
      it 'returns string version of normal grid' do
        expected_string = <<~TEXT
          C1 C2 C3 C4 C5 C6 C7
          🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫
          ⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫
          ⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫
          ⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫
        TEXT
        actual_string = board_string_normal.to_s
        expect(actual_string).to eql(expected_string)
      end
    end

    context 'when the board if full of disks of different colors' do
      let(:full_grid) do
        [
          %w[🔵 🔵 🔴 🔵 🔵 🔵 🔴],
          %w[🔴 🔴 🔴 🔴 🔵 🔴 🔵],
          %w[🔴 🔵 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔵 🔵],
          %w[🔵 🔴 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔴 🔵]
        ]
      end
      subject(:board_string_full) { described_class.new(full_grid) }
      it 'returns string version of full grid' do
        expected_string = <<~TEXT
          C1 C2 C3 C4 C5 C6 C7
          🔵 🔵 🔴 🔵 🔵 🔵 🔴
          🔴 🔴 🔴 🔴 🔵 🔴 🔵
          🔴 🔵 🔴 🔵 🔴 🔵 🔴
          🔵 🔵 🔴 🔴 🔵 🔵 🔵
          🔵 🔴 🔴 🔵 🔴 🔵 🔴
          🔵 🔵 🔴 🔴 🔵 🔴 🔵
        TEXT
        actual_string = board_string_full.to_s
        expect(actual_string).to eql(expected_string)
      end
    end
  end

  describe '#place_token' do
    # Incoming Command Message -> Check change of observable state

    context 'when the grid is empty' do
      subject(:board_place_empty) { described_class.new }
      it 'updates the grid with a blue token at the bottom of column 0, as intended' do
        expected_grid =
          [
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫]
          ]
        board_place_empty.place_token('🔵', 0)
        actual_grid = board_place_empty.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end

    context 'when the grid is normal: non-empty and non-full with a mixture of colored disks' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_place_col1_normal) { described_class.new(normal_grid) }
      it 'updates the grid with a red token at the bottom of column 1, as intended' do
        expected_grid =
          [
            %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
            %w[⚫ 🔴 🔴 🔴 🔵 ⚫ ⚫]
          ]
        board_place_col1_normal.place_token('🔴', 1)
        actual_grid = board_place_col1_normal.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end

    context 'when the grid is normal' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_place_col2_normal) { described_class.new(normal_grid) }
      it 'updates the grid with a blue token on top of the red tokens in column 2, as intended' do
        expected_grid =
          [
            %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
            %w[⚫ ⚫ 🔵 ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
          ]
        board_place_col2_normal.place_token('🔵', 2)
        actual_grid = board_place_col2_normal.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end

    context 'when the grid is normal' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_place_col4_normal) { described_class.new(normal_grid) }
      it 'updates the grid with a blue token on top of the other tokens in column 4, as intended' do
        expected_grid =
          [
            %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ 🔵 ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
          ]
        board_place_col4_normal.place_token('🔵', 4)
        actual_grid = board_place_col4_normal.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end

    context 'when the grid is normal' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_place_col0_normal) { described_class.new(normal_grid) }
      it 'does not update the grid when the token is blocked from a column by an existing token, as intended' do
        expected_grid =
          [
            %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
          ]
        board_place_col0_normal.place_token('🔴', 0)
        actual_grid = board_place_col0_normal.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end

    context 'when the grid is normal' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_place_negative_normal) { described_class.new(normal_grid) }
      it 'does not update the grid when the column is negative' do
        expected_grid =
          [
            %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
          ]
        board_place_negative_normal.place_token('🔴', -1)
        actual_grid = board_place_negative_normal.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end

    context 'when the grid is normal' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_place_too_large_normal) { described_class.new(normal_grid) }
      it 'does not update the grid when the column is too large: 7' do
        expected_grid =
          [
            %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
            %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
            %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
          ]
        board_place_too_large_normal.place_token('🔵', 7)
        actual_grid = board_place_too_large_normal.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end

    context 'when the grid is full of tokens of different colors' do
      let(:full_grid) do
        [
          %w[🔵 🔵 🔴 🔵 🔵 🔵 🔴],
          %w[🔴 🔴 🔴 🔴 🔵 🔴 🔵],
          %w[🔴 🔵 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔵 🔵],
          %w[🔵 🔴 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔴 🔵]
        ]
      end
      subject(:board_place_full) { described_class.new(full_grid) }
      it 'does not update the grid' do
        expected_grid =
          [
            %w[🔵 🔵 🔴 🔵 🔵 🔵 🔴],
            %w[🔴 🔴 🔴 🔴 🔵 🔴 🔵],
            %w[🔴 🔵 🔴 🔵 🔴 🔵 🔴],
            %w[🔵 🔵 🔴 🔴 🔵 🔵 🔵],
            %w[🔵 🔴 🔴 🔵 🔴 🔵 🔴],
            %w[🔵 🔵 🔴 🔴 🔵 🔴 🔵]
          ]
        board_place_full.place_token('🔴', 6)
        actual_grid = board_place_full.grid
        expect(actual_grid).to eql(expected_grid)
      end
    end
  end

  describe '#valid_move?' do
    # Incoming Query Message -> Test return value

    context 'when the grid is empty' do
      subject(:board_valid_empty) { described_class.new }

      it 'returns true' do
        expect(board_valid_empty).to be_valid_move 0
      end
    end

    context 'when the grid is normal: non-empty and non-full with a mixture of colored disks' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_valid_normal) { described_class.new(normal_grid) }

      it 'returns true for column 1' do
        expect(board_valid_normal).to be_valid_move 1
      end

      it 'returns true for column 2' do
        expect(board_valid_normal).to be_valid_move 2
      end

      it 'returns true for column 4' do
        expect(board_valid_normal).to be_valid_move 4
      end

      it 'returns false for blocked column 0' do
        expect(board_valid_normal).to_not be_valid_move 0
      end

      it 'returns false for column -1' do
        expect(board_valid_normal).to_not be_valid_move(-1)
      end

      it 'returns false for column -5' do
        expect(board_valid_normal).to_not be_valid_move(-5)
      end

      it 'returns false for column 7' do
        expect(board_valid_normal).to_not be_valid_move 7
      end
    end

    context 'when the grid is full' do
      let(:full_grid) do
        [
          %w[🔵 🔵 🔴 🔵 🔵 🔵 🔴],
          %w[🔴 🔴 🔴 🔴 🔵 🔴 🔵],
          %w[🔴 🔵 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔵 🔵],
          %w[🔵 🔴 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔴 🔵]
        ]
      end
      subject(:board_valid_full) { described_class.new(full_grid) }

      it 'returns false' do
        expect(board_valid_full).to_not be_valid_move 6
      end
    end
  end

  describe '#full?' do
    # Incoming Query Message -> Test the return value

    context 'when the grid is empty' do
      subject(:board_empty_check_full) { described_class.new }

      it 'returns false' do
        expect(board_empty_check_full).to_not be_full
      end
    end

    context 'when the grid is normal: non-empty and non-full with a mixture of colored disks' do
      let(:normal_grid) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_normal_check_full) { described_class.new(normal_grid) }

      it 'returns false' do
        expect(board_normal_check_full).to_not be_full
      end
    end

    context 'when the grid is full' do
      let(:full_grid) do
        [
          %w[🔵 🔵 🔴 🔵 🔵 🔵 🔴],
          %w[🔴 🔴 🔴 🔴 🔵 🔴 🔵],
          %w[🔴 🔵 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔵 🔵],
          %w[🔵 🔴 🔴 🔵 🔴 🔵 🔴],
          %w[🔵 🔵 🔴 🔴 🔵 🔴 🔵]
        ]
      end
      subject(:board_full_check_full) { described_class.new(full_grid) }

      it 'returns true' do
        expect(board_full_check_full).to be_full
      end
    end
  end

  describe '#four_in_row?' do
    # Incoming Query Message -> Test the value returned

    context 'when the grid is empty' do
      subject(:board_four_empty) { described_class.new }

      it 'returns false for red' do
        expect(board_four_empty).to_not be_four_in_row '🔴'
      end

      it 'returns false for blue' do
        expect(board_four_empty).to_not be_four_in_row '🔵'
      end
    end

    context 'when the grid has no four colors in a row and is normal: non-empty and non-full with a mixture of colored disks' do
      let(:grid_no_four) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_none) { described_class.new(grid_no_four) }

      it 'returns false for red' do
        expect(board_four_none).to_not be_four_in_row '🔴'
      end

      it 'returns false for blue' do
        expect(board_four_none).to_not be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row horizontally for red only' do
      let(:grid_red_four_horizontal) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[🔴 🔴 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_red_horizontal) { described_class.new(grid_red_four_horizontal) }

      it 'returns true for red' do
        expect(board_four_red_horizontal).to be_four_in_row '🔴'
      end

      it 'returns false for blue' do
        expect(board_four_red_horizontal).to_not be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row horizontally for blue only' do
      let(:grid_blue_four_horizontal) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[🔴 🔵 🔵 🔵 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_blue_horizontal) { described_class.new(grid_blue_four_horizontal) }

      it 'returns false for red' do
        expect(board_four_blue_horizontal).to_not be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_blue_horizontal).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row horizontally for both colors' do
      let(:grid_both_four_horizontal) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ 🔴 🔴 🔴 🔴],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[🔴 🔵 🔵 🔵 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_both_horizontal) { described_class.new(grid_both_four_horizontal) }

      it 'returns true for red' do
        expect(board_four_both_horizontal).to be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_both_horizontal).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row vertically for red only' do
      let(:grid_red_four_vertical) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 ⚫ 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[🔴 🔴 🔴 🔵 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_red_vertical) { described_class.new(grid_red_four_vertical) }

      it 'returns true for red' do
        expect(board_four_red_vertical).to be_four_in_row '🔴'
      end

      it 'returns false for blue' do
        expect(board_four_red_vertical).to_not be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row vertically for blue only' do
      let(:grid_blue_four_vertical) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[🔴 🔴 🔴 🔵 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_blue_vertical) { described_class.new(grid_blue_four_vertical) }

      it 'returns false for red' do
        expect(board_four_blue_vertical).to_not be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_blue_vertical).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row vertically for both colors' do
      let(:grid_both_four_vertical) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[🔴 🔴 🔴 🔵 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_both_vertical) { described_class.new(grid_both_four_vertical) }

      it 'returns true for red' do
        expect(board_four_both_vertical).to be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_both_vertical).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row on a backslash diagonal for red only' do
      let(:grid_red_four_backslash) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[🔴 ⚫ ⚫ 🔵 🔴 ⚫ ⚫],
          %w[⚫ 🔴 ⚫ 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_red_backslash) { described_class.new(grid_red_four_backslash) }

      it 'returns true for red' do
        expect(board_four_red_backslash).to be_four_in_row '🔴'
      end

      it 'returns false for blue' do
        expect(board_four_red_backslash).to_not be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row on a backslash diagonal for blue only' do
      let(:grid_blue_four_backslash) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ 🔵 ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔵 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_blue_backslash) { described_class.new(grid_blue_four_backslash) }

      it 'returns false for red' do
        expect(board_four_blue_backslash).to_not be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_blue_backslash).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row on a backslash diagonal for both colors' do
      let(:grid_both_four_backslash) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ 🔵 🔴 ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔵 🔴 🔴 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 🔴 ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_both_backslash) { described_class.new(grid_both_four_backslash) }

      it 'returns true for red' do
        expect(board_four_both_backslash).to be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_both_backslash).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row on a forward slash diagonal for red only' do
      let(:grid_red_four_forward_slash) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ 🔵 🔴 ⚫ 🔴],
          %w[⚫ ⚫ ⚫ 🔵 ⚫ 🔴 ⚫],
          %w[⚫ ⚫ 🔴 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_red_forward_slash) { described_class.new(grid_red_four_forward_slash) }

      it 'returns true for red' do
        expect(board_four_red_forward_slash).to be_four_in_row '🔴'
      end

      it 'returns false for blue' do
        expect(board_four_red_forward_slash).to_not be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row on a forward slash diagonal for blue only' do
      let(:grid_blue_four_forward_slash) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[⚫ ⚫ ⚫ ⚫ 🔵 ⚫ ⚫],
          %w[⚫ ⚫ ⚫ 🔵 🔴 ⚫ ⚫],
          %w[⚫ ⚫ 🔵 🔵 ⚫ ⚫ ⚫],
          %w[⚫ 🔵 🔴 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_blue_forward_slash) { described_class.new(grid_blue_four_forward_slash) }

      it 'returns false for red' do
        expect(board_four_blue_forward_slash).to_not be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_blue_forward_slash).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row on a forward slash diagonal for both colors' do
      let(:grid_both_four_forward_slash) do
        [
          %w[🔵 ⚫ ⚫ 🔴 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 ⚫ 🔵 ⚫ ⚫],
          %w[⚫ 🔴 ⚫ 🔵 🔴 ⚫ ⚫],
          %w[🔴 ⚫ 🔵 🔵 ⚫ ⚫ ⚫],
          %w[⚫ 🔵 🔴 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_both_forward_slash) { described_class.new(grid_both_four_forward_slash) }

      it 'returns true for red' do
        expect(board_four_both_forward_slash).to be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_both_forward_slash).to be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row in a mixture of directions for one color only; red' do
      let(:grid_red_four_mixture) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[🔴 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[🔴 ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[🔴 🔴 🔵 🔵 ⚫ ⚫ ⚫],
          %w[🔴 ⚫ 🔴 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_red_mixture) { described_class.new(grid_red_four_mixture) }

      it 'returns true for red' do
        expect(board_four_red_mixture).to be_four_in_row '🔴'
      end

      it 'returns false for blue' do
        expect(board_four_red_mixture).to_not be_four_in_row '🔵'
      end
    end

    context 'when a normal grid has four in a row in a mixture of directions for both colors' do
      let(:grid_both_four_mixture) do
        [
          %w[🔵 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[🔴 ⚫ ⚫ ⚫ ⚫ ⚫ ⚫],
          %w[🔴 ⚫ ⚫ ⚫ 🔴 ⚫ ⚫],
          %w[🔴 ⚫ 🔵 🔵 🔵 🔵 ⚫],
          %w[🔴 ⚫ 🔴 🔵 ⚫ ⚫ ⚫],
          %w[⚫ ⚫ 🔴 🔴 🔵 ⚫ ⚫]
        ]
      end
      subject(:board_four_both_mixture) { described_class.new(grid_both_four_mixture) }

      it 'returns true for red' do
        expect(board_four_both_mixture).to be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_both_mixture).to be_four_in_row '🔵'
      end
    end

    context 'when a full grid has four in a row for blue only' do
      let(:grid_blue_four_full) do
        [
          %w[🔵 🔴 🔵 🔵 🔵 🔴 🔵],
          %w[🔴 🔵 🔴 🔴 🔴 🔵 🔴],
          %w[🔵 🔴 🔵 🔴 🔴 🔴 🔵],
          %w[🔴 🔵 🔵 🔵 🔵 🔵 🔴],
          %w[🔵 🔴 🔴 🔵 🔴 🔴 🔵],
          %w[🔴 🔵 🔴 🔴 🔵 🔵 🔴]
        ]
      end
      subject(:board_four_blue_full) { described_class.new(grid_blue_four_full) }

      it 'returns false for red' do
        expect(board_four_blue_full).to_not be_four_in_row '🔴'
      end

      it 'returns true for blue' do
        expect(board_four_blue_full).to be_four_in_row '🔵'
      end
    end
  end
end

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
end

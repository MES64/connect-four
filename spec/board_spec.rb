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
end

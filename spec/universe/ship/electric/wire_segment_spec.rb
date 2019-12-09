require 'spec_helper'
require 'universe/ship/electric/wire_segment'

RSpec.describe Universe::Ship::Electric::WireSegment do

  describe 'intersection_with' do
    let(:segment1) { described_class.new('R6', [2, 2]) }

    context 'parallel lines' do
      it 'returns lowest intersection when align' do
        segment2 = described_class.new('R2', [4, 2])
        expect(segment1.intersection_with(segment2)).to eq([4, 2])
      end

      it 'returns nil when higher' do
        segment2 = described_class.new('R2', [4, 4])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end

      it 'returns nil when lower' do
        segment2 = described_class.new('R2', [4, 1])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end

      it 'returns nil when to the right' do
        segment2 = described_class.new('R2', [10, 2])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end

      it 'returns nil when to the left' do
        segment2 = described_class.new('R2', [-3, 2])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end
    end

    context 'perpendicular lines' do
      it 'returns position when crossing' do
        segment2 = described_class.new('D10', [4, 4])
        expect(segment1.intersection_with(segment2)).to eq([4, 2])
      end

      it 'returns nil when higher' do
        segment2 = described_class.new('D1', [4, 4])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end

      it 'returns nil when to the left' do
        segment2 = described_class.new('D10', [-5, 4])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end

      it 'returns nil when to the right' do
        segment2 = described_class.new('D10', [10, 4])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end

      it 'returns nil when lower' do
        segment2 = described_class.new('D10', [4, -2])
        expect(segment1.intersection_with(segment2)).to eq(nil)
      end
    end
  end
end
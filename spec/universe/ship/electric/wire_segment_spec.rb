require 'spec_helper'
require 'universe/ship/electric/wire_segment'

RSpec.describe Universe::Ship::Electric::WireSegment do

  describe 'intersects_with_projection_of?' do
    context 'for horizontal line' do
      let(:segment) { described_class.new('R6', [2, 2]) }

      it 'returns true when point higher and between ends' do
        expect(segment.intersects_with_projection_of?([4, 4])).to be_truthy
      end

      it 'returns true when point lower and between ends' do
        expect(segment.intersects_with_projection_of?([4, -120])).to be_truthy
      end

      it 'returns true when directly on the line' do
        expect(segment.intersects_with_projection_of?([5, 2])).to be_truthy
      end

      it 'returns false when out to left' do
        expect(segment.intersects_with_projection_of?([-5, 2])).to be_falsey
      end

      it 'returns false when out to right' do
        expect(segment.intersects_with_projection_of?([15, -5])).to be_falsey
      end
    end
  end
  
  describe 'intersection_with' do
    let(:segment1) { described_class.new('R6', [2, 2]) }

    it 'returns position when crossing' do
      segment2 = described_class.new('D10', [4, 4])
      expect(segment1.intersection_with(segment2)).to eq([4, 2])
    end

    it 'returns nil when higher', pending: true do
      segment2 = described_class.new('D1', [4, 4])
      expect(segment1.intersection_with(segment2)).to eq(nil)
    end

    it 'returns nil when parallel', pending: true do
      segment2 = described_class.new('R2', [4, 4])
      expect(segment1.intersection_with(segment2)).to eq(nil)
    end

    it 'returns nil when to the left' do
      segment2 = described_class.new('D10', [-5, 4])
      expect(segment1.intersection_with(segment2)).to eq(nil)
    end
  end
end
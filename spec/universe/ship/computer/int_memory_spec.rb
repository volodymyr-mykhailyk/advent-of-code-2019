require 'spec_helper'
require 'universe/ship/computer/int_memory'

RSpec.describe Universe::Ship::Computer::IntMemory do
  subject { described_class.new(memory) }

  let(:memory) { [0, 1, 4, 3] }

  describe '.get_value' do
    it 'returns value' do
      expect(subject.get_value(2)).to eq(4)
    end

    it 'raises error when negative address' do
      expect { subject.get_value(-1) }.to raise_error('Invalid address: -1')
    end
  end

  describe '.put_value' do
    it 'updates value' do
      subject.put_value(2, 0)
      expect(subject.get_value(2)).to eq(0)
    end

    it 'does not update value when error' do
      subject.put_value(-1, 0)
    rescue => _
      expect(subject.contents).to eq([0, 1, 4, 3])
    end

    it 'raises error when negative address' do
      expect { subject.put_value(-1, 0) }.to raise_error('Invalid address: -1')
    end
  end

  describe '.pointer' do
    it 'default on initialize' do
      expect(subject.pointer).to eq(0)
    end
  end

  describe '.relative_pointer' do
    it 'default on initialize' do
      expect(subject.relative_pointer).to eq(0)
    end
  end

  describe '.advance_relative_by' do
    it 'updates pointer' do
      subject.advance_relative_by(2)
      expect(subject.relative_pointer).to eq(2)
    end
  end

  describe '.advance_by' do
    it 'updates pointer' do
      subject.advance_by(2)
      expect(subject.pointer).to eq(2)
    end
  end
end
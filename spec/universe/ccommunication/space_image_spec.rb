require 'spec_helper'
require 'universe/communication/space_image'

RSpec.describe Universe::Communication::SpaceImage do
  describe '.layers' do
    let(:digits) { '111226789012001122'.split('').map(&:to_i) }
    subject { described_class.new(digits, 3, 2) }

    it 'has correct number of layers' do
      expect(subject.layers.length).to eq(3)
    end

    it 'has correct layer data' do
      layer = subject.layers[1]
      expect(layer.digits).to eq([7, 8, 9, 0, 1, 2])
    end

    it 'has correct checksum' do
      expect(subject.checksum).to eq(6)
    end
  end

  describe '.visible_image' do
    let(:digits) { '0222112222120000'.split('').map(&:to_i) }
    subject { described_class.new(digits, 2, 2) }

    it 'producing_correct_output' do
      expect(subject.visible_image).to eq([[0, 1], [1, 0]])
    end
  end
end
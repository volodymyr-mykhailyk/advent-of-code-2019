require 'spec_helper'
require 'universe/navigation/objects_map'
require 'universe/navigation/objects_map_factory'

RSpec.describe Universe::Navigation::ObjectsMap do
  let(:factory) { Universe::Navigation::ObjectsMapFactory.new }
  let(:objects) { [%w(# . .), %w(. . .), %w(. # .)] }
  subject { described_class.new(objects, factory) }

  describe '.at' do

    it 'returns correct wall object' do
      expect(subject.at(0, 0)).to be_instance_of(Universe::Navigation::Objects::Wall)
    end

    it 'returns correct void object' do
      expect(subject.at(0, 2)).to be_instance_of(Universe::Navigation::Objects::Void)
    end

    it 'raise bounds error' do
      expect { subject.at(0, 3) }.to raise_error('Position out of bounds')
    end
  end

  describe '.presentation' do
    it 'returns correct value' do
      expect(subject.presentation).to eq("#..\n...\n.#.")
    end
  end
end
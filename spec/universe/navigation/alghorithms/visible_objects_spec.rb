require 'spec_helper'
require 'universe/navigation/objects_map'
require 'universe/navigation/objects_map_factory'
require 'universe/navigation/algorithms/visible_objects'

RSpec.describe Universe::Navigation::Algorithms::VisibleObjects do
  MAP = <<MAP
.#..#
.....
#####
....#
...##
MAP

  let(:factory) { Universe::Navigation::ObjectsMapFactory.new }
  let(:objects) { MAP.split("\n").map { |line| line.split('') } }
  let(:map) { Universe::Navigation::ObjectsMap.new(objects, factory) }
  subject { described_class.new(map) }

  describe '.calculate_from_position' do
    it 'returns correct value for 0, 0' do
      position = Universe::Navigation::Position.new(0, 0)
      expect(subject.calculate_from_position(position)).to eq(5)
    end

    it 'returns correct value for 3, 4' do
      position = Universe::Navigation::Position.new(3, 4)
      expect(subject.calculate_from_position(position)).to eq(8)
    end

    it 'returns correct value for 3, 4' do
      position = Universe::Navigation::Position.new(3, 4)
      expect(subject.calculate_from_position(position)).to eq(8)
    end
  end
end
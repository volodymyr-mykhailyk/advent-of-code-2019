require 'spec_helper'
require 'universe/ship/navigation/orbits_map'

RSpec.describe Universe::Ship::Navigation::OrbitsMap do
  describe '.checksum' do
    [
      {input: ['A)B'], output: 1},
      {input: ['A)B', 'B)C'], output: 3},
      {input: ['B)C', 'A)B'], output: 3},
      {input: ['A)B', 'C)D', 'B)C'], output: 6},
      {input: ['A)B', 'B)C', 'C)D'], output: 6},
      {input: ['COM)B', 'B)C', 'C)D', 'D)E', 'E)F', 'B)G', 'G)H', 'D)I', 'E)J', 'J)K', 'K)L'], output: 42},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        map = described_class.new(input)
        expect(map.checksum).to eq(output)
      end
    end
  end

  describe '.shortest_transfer_between' do
    MAP = ['COM)B', 'B)C', 'C)D', 'D)E', 'E)F', 'B)G', 'G)H', 'D)I', 'E)J', 'J)K', 'K)L', 'K)YOU', 'I)SAN']
    [
      {input: ['YOU', 'SAN'], output: ['D-E', 'E-J', 'J-K', 'D-I']},
      {input: ['SAN', 'YOU'], output: ['D-I', 'D-E', 'E-J', 'J-K']},
      {input: ['G', 'SAN'], output: ['B-C', 'C-D', 'D-I']},
      {input: ['YOU', 'G'], output: ['B-C', 'C-D', 'D-E', 'E-J', 'J-K']},
    ].each do |input:, output:|
      it "returns correct transfers for #{input}" do
        map = described_class.new(MAP)
        expect(map.shortest_transfer_between(*input)).to eq(output)
      end
    end
  end
end
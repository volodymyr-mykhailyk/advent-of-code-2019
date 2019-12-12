require 'spec_helper'
require 'universe/ship/hull_painting_robot'

RSpec.describe Universe::Ship::HullPaintingRobot do
  [
    {program: [3, 20, 104, 1, 104, 0, 3, 20, 104, 1, 104, 0, 99], output: 2, map: [[0, 0, 0], [1, 1, 0], [0, 0, 0]]}
  ].each do |program:, output:, map:|
    it 'returns correct painted panels count' do
      robot = described_class.new(program, 3)
      robot.paint_side_panel
      expect(robot.painted_panels_count).to eq(output)
    end

    it 'returns correct map' do
      robot = described_class.new(program, 3)
      robot.paint_side_panel
      expect(robot.map).to eq(map)
    end
  end
end
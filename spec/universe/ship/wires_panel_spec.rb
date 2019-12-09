require 'spec_helper'
require 'universe/ship/wires_panel'

RSpec.describe Universe::Ship::WiresPanel, pending: true do
  Scenarios.for_each_in('wires_panel.yml') do |scenario|
    describe scenario.title do
      it 'calculates correct coordinates for wires crossing' do
        scenario.input.each { |wire_path| subject.add_wire(wire_path) }
        expect(subject.closest_intersection_to([0, 0])).to eq(scenario.output)
      end
    end
  end
end
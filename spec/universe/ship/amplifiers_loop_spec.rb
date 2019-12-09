require 'spec_helper'
require 'universe/ship/amplifiers_loop'

RSpec.describe Universe::Ship::AmplifiersLoop do
  describe '.output_for' do
    Scenarios.for_each_in('amplifiers_loop.yml') do |scenario|
      describe scenario.title do
        it "produces correct output" do
          computer = described_class.new(scenario.program)
          expect(computer.output_for(scenario.input)).to eq(scenario.output)
        end
      end
    end
  end
end
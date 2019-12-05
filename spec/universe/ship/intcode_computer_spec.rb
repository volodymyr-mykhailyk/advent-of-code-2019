require 'spec_helper'
require 'universe/ship/intcode_computer'

RSpec.describe Universe::Ship::IntcodeComputer do
  describe 'programs' do
    Scenarios.for_each_in('intcode_computer.yml') do |scenario|
      describe scenario.title do
        it "produces correct state" do
          computer = described_class.new(scenario.program, scenario.input)
          expect(computer.run_program).to eq(scenario.state)
        end

        it "produces correct output" do
          computer = described_class.new(scenario.program, scenario.input)
          computer.run_program
          expect(computer.output).to eq(scenario.output)
        end
      end
    end
  end

  describe '.input' do
    subject { described_class.new([99], [3, 2]) }

    it 'returns first input' do
      expect(subject.get_input).to eq(3)
    end

    it 'shifts input stack' do
      subject.get_input
      expect(subject.get_input).to eq(2)
    end
  end

  describe '.output' do
    subject { described_class.new([99]) }

    it 'is empty on start' do
      expect(subject.output).to eq([])
    end

    it 'records output' do
      subject.put_output(2)
      subject.put_output(1)
      expect(subject.output).to eq([2, 1])
    end
  end
end
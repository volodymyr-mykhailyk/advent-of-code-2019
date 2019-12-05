require 'spec_helper'
require 'universe/ship/intcode_computer'

RSpec.describe Universe::Ship::IntcodeComputer do
  describe '.run_program' do
    PROGRAMS = [
      {program: [99], input: [], output: [], state: [99]},
      {program: [1, 0, 0, 0, 99], input: [], output: [], state: [2, 0, 0, 0, 99]},
      {program: [2, 3, 0, 3, 99], input: [], output: [], state: [2, 3, 0, 6, 99]},
      {program: [2, 4, 4, 5, 99, 0], input: [], output: [], state: [2, 4, 4, 5, 99, 9801]},
      {program: [1, 1, 1, 4, 99, 5, 6, 0, 99], input: [], output: [], state: [30, 1, 1, 4, 2, 5, 6, 0, 99]},
      {program: [4, 0, 99], input: [], output: [4], state: [4, 0, 99]},
      {program: [1101, 100, -1, 4, 0], input: [], output: [], state: [1101, 100, -1, 4, 99]},
      {program: [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], input: [8], output: [1], state: [3, 9, 8, 9, 10, 9, 4, 9, 99, 1, 8]},
      {program: [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], input: [9], output: [0], state: [3, 9, 8, 9, 10, 9, 4, 9, 99, 0, 8]},
      {program: [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], input: [7], output: [1], state: [3, 9, 8, 9, 10, 9, 4, 9, 99, 1, 8]},
      {program: [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], input: [8], output: [0], state: [3, 9, 8, 9, 10, 9, 4, 9, 99, 0, 8]},
      {program: [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99], input: [5], output: [999], state: []},
      {program: [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99], input: [8], output: [1000], state: []},
      {program: [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99], input: [12], output: [1001], state: []},
    ]

    PROGRAMS.each do |program:, input:, output:, state:|
      it "produce correct state for #{program} program" do
        computer = described_class.new(program, input)
        expect(computer.run_program).to match(state)
      end

      it "produce correct output for #{program} program" do
        computer = described_class.new(program, input)
        computer.run_program
        expect(computer.output).to eq(output)
      end
    end
  end

  describe '.run_command' do
    COMMANDS = [
      {input: [1, 0, 0, 0], output: [2, 0, 0, 0]},
      {input: [1, 4, 4, 4, 0], output: [1, 4, 4, 4, 0]},
      {input: [2, 4, 4, 4, 0], output: [2, 4, 4, 4, 0]},
    ]

    COMMANDS.each do |input:, output:|
      it "correctly executes for #{input} state" do
        computer = described_class.new(input)
        expect(computer.run_instruction).to eq(output)
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
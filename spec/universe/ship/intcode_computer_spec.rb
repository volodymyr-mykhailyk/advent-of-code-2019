require 'spec_helper'
require 'universe/ship/intcode_computer'

RSpec.describe Universe::Ship::IntcodeComputer do
  describe '.run_program' do
    PROGRAMS = [
      {input: [99], output: [99]},
      {input: [1, 0, 0, 0, 99], output: [2, 0, 0, 0, 99]},
      {input: [2, 3, 0, 3, 99], output: [2, 3, 0, 6, 99]},
      {input: [2, 4, 4, 5, 99, 0], output: [2, 4, 4, 5, 99, 9801]},
      {input: [1, 1, 1, 4, 99, 5, 6, 0, 99], output: [30, 1, 1, 4, 2, 5, 6, 0, 99]},
      {input: [4, 0, 99], output: [4, 0, 99]},
    ]

    PROGRAMS.each do |input:, output:|
      it "correctly executes for #{input} state" do
        computer = described_class.new(input)
        expect(computer.run_program).to eq(output)
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
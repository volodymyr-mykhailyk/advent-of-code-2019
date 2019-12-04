require 'spec_helper'
require 'universe/ship/intcode_computer'

RSpec.describe Universe::Ship::IntcodeComputer do
  describe '.run_program' do
    PROGRAMS = [
      {input: [1, 0, 0, 0, 99], output: [2, 0, 0, 0, 99]},
      {input: [2, 3, 0, 3, 99], output: [2, 3, 0, 6, 99]},
      {input: [2, 4, 4, 5, 99, 0], output: [2, 4, 4, 5, 99, 9801]},
      {input: [1, 1, 1, 4, 99, 5, 6, 0, 99], output: [30, 1, 1, 4, 2, 5, 6, 0, 99]},
    ]

    PROGRAMS.each do |verification|
      it "correctly executes for #{verification[:input]} state" do
        computer = described_class.new(verification[:input])
        expect(computer.run_program).to eq(verification[:output])
      end
    end
  end

  describe '.run_command' do
    COMMANDS = [
      {input: [1, 0, 0, 0], output: [2, 0, 0, 0]},
      {input: [1, 4, 4, 4, 0], output: [1, 4, 4, 4, 0]},
      {input: [2, 4, 4, 4, 0], output: [2, 4, 4, 4, 0]},
    ]

    COMMANDS.each do |verification|
      it "correctly executes for #{verification[:input]} state" do
        computer = described_class.new(verification[:input])
        expect(computer.run_command).to eq(verification[:output])
      end
    end
  end
end
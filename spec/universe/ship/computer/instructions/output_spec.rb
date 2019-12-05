require 'spec_helper'
require 'universe/ship/intcode_computer'
require 'universe/ship/computer/int_memory'
require 'universe/ship/computer/instructions/output'

RSpec.describe Universe::Ship::Computer::Instructions::Output do
  subject { described_class.new(computer) }

  let(:computer) { instance_double(Universe::Ship::IntcodeComputer, put_output: true) }

  describe '.matches?' do
    [
      {input: [4], output: true},
      {input: [2], output: false},
      {input: [104], output: true},
      {input: [1004], output: true},
      {input: [10004], output: true},
      {input: [103], output: false},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = Universe::Ship::Computer::IntMemory.new(input)
        expect(subject.up_next_in?(memory)).to eq(output)
      end
    end
  end

  describe '.execute' do
    [
      {input: [4, 0], output: 4},
      {input: [104, 2, 99], output: 2},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = build_memory(input)
        subject.execute_in(memory)
        expect(computer).to have_received(:put_output).with(output)
      end
    end

    it "does not modifies memory" do
      memory = build_memory([4, 0])
      subject.execute_in(memory)
      expect(memory.contents).to eq([4, 0])
    end

    it "advancing to correct pointer" do
      memory = build_memory([104, 2, 99])
      subject.execute_in(memory)
      expect(memory.pointer).to eq(2)
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
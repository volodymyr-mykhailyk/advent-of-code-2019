require 'spec_helper'
require 'universe/ship/intcode_computer'
require 'universe/ship/computer/int_memory'
require 'universe/ship/computer/instructions/input'

RSpec.describe Universe::Ship::Computer::Instructions::Input do
  subject { described_class.new(computer) }

  let(:computer) { instance_double(Universe::Ship::IntcodeComputer, get_input: 33) }

  describe '.matches?' do
    [
      {input: [3], output: true},
      {input: [2], output: false},
      {input: [103], output: true},
      {input: [1003], output: true},
      {input: [10003], output: true},
      {input: [104], output: false},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = Universe::Ship::Computer::IntMemory.new(input)
        expect(subject.up_next_in?(memory)).to eq(output)
      end
    end
  end

  describe '.execute' do
    [
      {input: [3, 0], output: [33, 0]},
      {input: [3, 2, 0, 99], output: [3, 2, 33, 99]},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = build_memory(input)
        subject.execute_in(memory)
        expect(memory.contents).to eq(output)
      end
    end

    it "advancing to correct pointer" do
      memory = build_memory([3, 0, 99])
      subject.execute_in(memory)
      expect(memory.pointer).to eq(2)
    end

    context 'when no input' do
      let(:computer) { instance_double(Universe::Ship::IntcodeComputer, get_input: nil) }

      it 'raising error' do
        memory = build_memory([3, 0, 99])
        expect { subject.execute_in(memory) }.to raise_error(Universe::Ship::Errors::InputRequired)
      end
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
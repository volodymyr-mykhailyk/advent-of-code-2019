require 'spec_helper'
require 'universe/ship/computer/int_memory'
require 'universe/ship/errors/end_of_program'
require 'universe/ship/computer/instructions/exit'

RSpec.describe Universe::Ship::Computer::Instructions::Exit do
  describe '.matches?' do
    [
      {input: [99], output: true},
      {input: [1], output: false},
      {input: [2], output: false},
      {input: [199], output: true},
      {input: [1099], output: true},
      {input: [103], output: false},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = Universe::Ship::Computer::IntMemory.new(input)
        expect(subject.up_next_in?(memory)).to eq(output)
      end
    end
  end

  describe '.execute' do
    it "Raises EndOfProgram" do
      memory = build_memory([99])
      expect { subject.execute_in(memory) }.to raise_error(Universe::Ship::Errors::EndOfProgram)
    end

    it "not advancing to next instruction" do
      memory = build_memory([99, 0])
      expect { subject.execute_in(memory) }.to raise_error(Universe::Ship::Errors::EndOfProgram)
      expect(memory.pointer).to eq(0)
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
require 'spec_helper'
require 'universe/ship/intcode_computer'
require 'universe/ship/computer/int_memory'
require 'universe/ship/computer/instructions/adjust_relative_pointer'

RSpec.describe Universe::Ship::Computer::Instructions::AdjustRelativePointer do
  subject { described_class.new(computer) }

  let(:computer) { instance_double(Universe::Ship::IntcodeComputer, get_input: 33) }

  describe '.execute' do
    [
      {program: [109, 3, 99, 0], pointer: 3},
      {program: [109, -5], pointer: -5},
      {program: [9, 0], pointer: 109},
    ].each do |program:, pointer:|
      it "sets correct relative pointer value for #{program}" do
        memory = build_memory(program)
        subject.execute_in(memory)
        expect(memory.relative_pointer).to eq(pointer)
      end
    end

    it "advancing to correct pointer" do
      memory = build_memory([9, 0, 99])
      subject.execute_in(memory)
      expect(memory.pointer).to eq(2)
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
require 'spec_helper'
require 'universe/ship/computer/int_memory'
require 'universe/ship/computer/instructions/jump_if_false'

RSpec.describe Universe::Ship::Computer::Instructions::JumpIfFalse do
  subject { described_class.new(double('computer')) }

  describe '.execute' do
    [
      {input: [6, 0, 4, 99, 5, 99], output: [6, 0, 4, 99, 5, 99], pointer: 3},
      {input: [1106, 0, 4, 99, 99], output: [1106, 0, 4, 99, 99], pointer: 4},
      {input: [1106, -1, 4, 99, 99], output: [1106, -1, 4, 99, 99], pointer: 3},
      {input: [1106, 3, 4, 99, 99], output: [1106, 3, 4, 99, 99], pointer: 3},
    ].each do |input:, output:, pointer:|
      describe "with input #{input}" do
        it "returns correct memory for #{input}" do
          memory = build_memory(input)
          subject.execute_in(memory)
          expect(memory.contents).to eq(output)
        end

        it "advancing to correct pointer" do
          memory = build_memory(input)
          subject.execute_in(memory)
          expect(memory.pointer).to eq(pointer)
        end
      end
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
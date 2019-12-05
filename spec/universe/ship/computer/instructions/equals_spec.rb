require 'spec_helper'
require 'universe/ship/computer/int_memory'
require 'universe/ship/computer/instructions/equals'

RSpec.describe Universe::Ship::Computer::Instructions::Equals do
  subject { described_class.new(double('computer')) }

  describe '.execute' do
    [
      {input: [1108, 3, 4, 4, -1], output: [1108, 3, 4, 4, 0]},
      {input: [1108, 4, 3, 4, -1], output: [1108, 4, 3, 4, 0]},
      {input: [8, 0, 0, 4, -1], output: [8, 0, 0, 4, 1]},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = build_memory(input)
        subject.execute_in(memory)
        expect(memory.contents).to eq(output)
      end
    end

    it "advancing to correct pointer" do
      memory = build_memory([8, 0, 0, 0, 99])
      subject.execute_in(memory)
      expect(memory.pointer).to eq(4)
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
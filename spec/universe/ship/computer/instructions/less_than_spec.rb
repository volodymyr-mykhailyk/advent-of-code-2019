require 'spec_helper'
require 'universe/ship/computer/int_memory'
require 'universe/ship/computer/instructions/less_than'

RSpec.describe Universe::Ship::Computer::Instructions::LessThan do
  subject { described_class.new(double('computer')) }

  describe '.execute' do
    [
      {input: [1107, 3, 4, 4, -1], output: [1107, 3, 4, 4, 1]},
      {input: [1107, 4, 3, 4, -1], output: [1107, 4, 3, 4, 0]},
      {input: [7, 0, 0, 4, -1], output: [7, 0, 0, 4, 0]},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = build_memory(input)
        subject.execute_in(memory)
        expect(memory.contents).to eq(output)
      end
    end

    it "advancing to correct pointer" do
      memory = build_memory([7, 0, 0, 0, 99])
      subject.execute_in(memory)
      expect(memory.pointer).to eq(4)
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
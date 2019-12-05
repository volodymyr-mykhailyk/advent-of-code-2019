require 'spec_helper'
require 'universe/ship/computer/instructions/multiply'
require 'universe/ship/computer/int_memory'

RSpec.describe Universe::Ship::Computer::Instructions::Multiply do
  subject { described_class.new(double('computer')) }

  describe '.matches?' do
    [
      {input: [2], output: true},
      {input: [1], output: false},
      {input: [3], output: false},
      {input: [102], output: true},
      {input: [1002], output: true},
      {input: [10002], output: true},
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
      {input: [2, 0, 0, 0, 99], output: [4, 0, 0, 0, 99]},
      {input: [2, 0, 0, 3, 99], output: [2, 0, 0, 4, 99]},
      {input: [102, 0, 0, 3, 99], output: [102, 0, 0, 0, 99]},
    ].each do |input:, output:|
      it "returns correct value for #{input}" do
        memory = build_memory(input)
        subject.execute_in(memory)
        expect(memory.contents).to eq(output)
      end
    end

    it "advancing to correct pointer" do
      memory = build_memory([2, 0, 0, 0, 99])
      subject.execute_in(memory)
      expect(memory.pointer).to eq(4)
    end
  end

  protected

  def build_memory(input)
    Universe::Ship::Computer::IntMemory.new(input)
  end
end
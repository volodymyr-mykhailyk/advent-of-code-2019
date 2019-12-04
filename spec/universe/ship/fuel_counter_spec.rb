require 'spec_helper'
require 'universe/ship/fuel_counter'

RSpec.describe Universe::Ship::FuelCounter do
  describe '.fuel_equation' do
    FUEL_EQUATIONS = [
      {input: 4, output: -1},
      {input: 12, output: 2},
      {input: 14, output: 2},
      {input: 1969, output: 654},
      {input: 100756, output: 33583},
    ]

    FUEL_EQUATIONS.each do |verification|
      it "works with #{verification}" do
        result = subject.fuel_equation(verification[:input])
        expect(result).to eq(verification[:output])
      end
    end
  end

  describe '.for_module' do
    MODULE_FUEL = [
      {input: 4, output: 0},
      {input: 14, output: 2},
      {input: 1969, output: 654 + 216 + 70 + 21 + 5},
      {input: 100756, output: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2},
    ]

    MODULE_FUEL.each do |verification|
      it "works with #{verification}" do
        result = subject.for_module(verification[:input])
        expect(result).to eq(verification[:output])
      end
    end
  end
end
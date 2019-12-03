module Day01
  class Verifications
    def self.fuel_equation
      [
        {input: 4, output: -1},
        {input: 12, output: 2},
        {input: 14, output: 2},
        {input: 1969, output: 654},
        {input: 100756, output: 33583},
      ]
    end

    def self.fuel_for_mass
      [
        {input: 4, output: 0},
        {input: 14, output: 2},
        {input: 1969, output: 654 + 216 + 70 + 21 + 5},
        {input: 100756, output: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2},
      ]
    end

    def self.total_fuel_for_modules
      [
        {input: [10], output: 1},
        {input: [12], output: 2},
        {input: [12, 12], output: 4},
        {input: [20, 13], output: 6},
        {input: [20, 20, 13], output: 10},
        {input: [33, 20], output: 14},
      ]
    end
  end
end
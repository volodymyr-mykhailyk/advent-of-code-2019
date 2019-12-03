module Day01
  class Verifications
    def self.module_fuel_requirements
      [
        {input: 4, output: 0},
        {input: 12, output: 2},
        {input: 14, output: 2},
        {input: 1969, output: 654},
        {input: 100756, output: 33583},
      ]
    end

    def self.total_fuel_requirements
      [
        {input: [4, 12], output: 2},
        {input: [12, 14], output: 2 + 2},
        {input: [12, 14, 1969, 100756], output: 2 + 2 + 654 + 33583},
      ]
    end
  end
end
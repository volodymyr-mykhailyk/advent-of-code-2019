module Day01
  class Verifications
    def self.module_fuel_requirements
      [
        {input: 12, output: 4},
        {input: 14, output: 4},
        {input: 1969, output: 654},
        {input: 100756, output: 33583},
      ]
    end

    def self.total_fuel_requirements
      [
        {input: [12, 14], output: 4+4},
        {input: [12, 14, 1969, 100756], output: 4+4+654+33583},
      ]
    end
  end
end
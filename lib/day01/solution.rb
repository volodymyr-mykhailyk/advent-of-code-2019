module Day01
  class Solution
    def module_fuel_requirements(mass)
      return 0 unless mass > 8
      (mass / 3.0).floor - 2
    end

    def total_fuel_requirements(list_of_modules)
      list_of_modules.sum(&method(:module_fuel_requirements))
    end
  end
end
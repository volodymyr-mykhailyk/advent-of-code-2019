module Day01
  class Solution
    def fuel_equation(mass)
      (mass / 3.0).floor - 2
    end

    def fuel_for_mass(mass)
      return 0 unless (fuel = fuel_equation(mass)) > 0

      fuel + fuel_for_mass(fuel)
    end

    def total_fuel_for_modules(list_of_modules)
      list_of_modules.sum(&method(:fuel_for_mass))
    end
  end
end
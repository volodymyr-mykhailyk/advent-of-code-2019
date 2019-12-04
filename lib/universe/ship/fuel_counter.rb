module Universe
  module Ship
    class FuelCounter
      def for_module(mass)
        return 0 unless (fuel = fuel_equation(mass)) > 0

        fuel + for_module(fuel)
      end

      def fuel_equation(mass)
        (mass / 3.0).floor - 2
      end
    end
  end
end
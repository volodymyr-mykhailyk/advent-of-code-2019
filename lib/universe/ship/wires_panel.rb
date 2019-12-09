require_relative 'electric/wire'

module Universe
  module Ship
    class WiresPanel
      def initialize
        @wires = []
      end

      def add_wire(path)
        @wires << Electric::Wire.new(path, [0, 0])
      end

      def closest_intersection_to(position)
        all_intersections = @wires.map do |wire1|
          (@wires - [wire1]).map do |wire2|
            wire1.segments.map { |segment| wire2.intersections_with(segment) }
          end
        end.flatten.compact
      end
    end
  end
end
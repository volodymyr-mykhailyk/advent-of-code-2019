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

      def closest_intersection_to(position = [0, 0])
        all_intersections = []
        @wires.each.with_index do |wire1, index|
          @wires[(index+1)..].each do |wire2|
            wire1.segments.each do |segment|
              all_intersections.concat wire2.intersections_with(segment).compact
            end
          end
        end
        all_intersections = all_intersections.reject {|intersection| intersection == [0, 0]}
        all_intersections.sort_by {|intersection| distance_between(position, intersection)}.first
      end

      def distance_between(position1, position2)
        x = position1[0] - position2[0]
        y = position1[1] - position2[1]
        x.abs + y.abs
      end
    end
  end
end
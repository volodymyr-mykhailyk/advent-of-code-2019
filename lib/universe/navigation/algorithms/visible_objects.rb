require_relative '../traversing/solid_objects'

module Universe
  module Navigation
    module Algorithms
      class VisibleObjects
        def initialize(map)
          @map = map
          @solid_objects = visible_objects_for(map)
        end

        def calculate_from_position(position)
          distances = @solid_objects.map do |object|
            distance = distance_between(position, object.position)
            [minimized_distance(*distance), object]
          end
          distances.reject { |distance, _object| distance == [0, 0] }
          distances.group_by { |distance, _object| distance }.count
        end

        protected

        def visible_objects_for(map)
          traverser = Navigation::Traversing::SolidObjects.new(map)
          traverser.to_a
        end

        def distance_between(position1, position2)
          [position1.pos_x - position2.pos_x, position1.pos_y - position2.pos_y]
        end

        def minimized_distance(x, y)
          sign_x = x == 0 ? 1 : x / x.abs
          sign_y = y == 0 ? 1 : y / y.abs
          [sign_x * minimized_number(x.abs), sign_y * minimized_number(y.abs)]
        end

        def minimized_number(n, division = 2)
          #puts "minimized_number: #{n}, #{division}"
          return n if n < 4
          return n if n <= division

          if n % division == 0
            minimized_number(n / division, division)
          else
            minimized_number(n, division + 1)
          end
        end
      end
    end
  end
end
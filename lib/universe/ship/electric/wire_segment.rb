module Universe
  module Ship
    module Electric
      class WireSegment
        NAVIGATION_MAP = {
          R: [1, 0],
          D: [0, -1],
          L: [-1, 0],
          U: [0, 1],
        }.freeze

        attr_reader :start_position, :end_position

        def initialize(path, start_position)
          @direction, @distance = parse_path(path)
          @start_position = start_position
          @end_position = calculate_end_position(@direction, @distance, start_position)
        end

        def intersection_with(segment)
          return nil unless intersects_with_projection_of?(segment.start_position)
          return nil unless intersects_with_projection_of?(segment.end_position)

          s1_coordinate, s1_range = dimensions
          s2_coordinate, s2_range = segment.dimensions

          position = []
          position[s1_coordinate] = segment.start_position[s1_coordinate]
          position[s2_coordinate] = start_position[s2_coordinate]
          position
        end

        def intersects_with_projection_of?(position)
          coordinate, range = dimensions
          range.include?(position[coordinate])
        end

        def dimensions
          x1, y1 = start_position
          x2, y2 = end_position
          if x1 == x2
            [1, (y1..y2)]
          else
            [0, (x1..x2)]
          end
        end

        protected

        def calculate_end_position(direction, distance, coords)
          delta = NAVIGATION_MAP[direction].map { |multiplier| multiplier * distance }
          puts '***' * 10
          puts delta.inspect
          puts @path.inspect
          puts 'R6'[0].to_sym.inspect
          coords.map.with_index { |value, index| value + delta[index] }
        end

        def parse_path(path)
          info = path.clone
          [info[0].to_sym, info[1, 10].to_i]
        end
      end
    end
  end
end
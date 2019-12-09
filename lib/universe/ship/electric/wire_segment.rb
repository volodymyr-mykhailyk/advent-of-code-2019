module Universe
  module Ship
    module Electric
      class WireSegment
        attr_reader :start_position, :end_position, :direction, :distance, :orientation, :range_x, :range_y

        def initialize(path, start_position)
          @direction, @distance = parse_path(path)
          @start_position, @end_position = calculate_positions(start_position)
          @orientation, @range_x, @range_y = calculate_ranges
        end

        def intersection_with(segment)
          return parallel_intersection(segment) if segment.orientation == orientation
          if orientation == :H
            horizontal_intersection(segment)
          else
            vertical_intersection(segment)
          end
        end

        def parallel_intersection(segment)
          if orientation == :H
            return unless height_delta == segment.height_delta
            return unless (intersection = range_x.find { |x| segment.range_x.include?(x) })
            [intersection, height_delta]
          else
            return unless width_delta == segment.width_delta
            return unless (intersection = range_y.find { |y| segment.range_y.include?(y) })
            [width_delta, intersection]
          end
        end

        def horizontal_intersection(segment)
          return unless range_x.include?(segment.width_delta) && segment.range_y.include?(height_delta)

          [segment.width_delta, height_delta]
        end

        def vertical_intersection(segment)
          return unless segment.range_x.include?(width_delta) && range_y.include?(segment.height_delta)

          [width_delta, segment.height_delta]
        end

        def width_delta
          start_position[0]
        end

        def height_delta
          start_position[1]
        end

        protected

        NAVIGATION_MAP = {
          R: [1, 0],
          D: [0, -1],
          L: [-1, 0],
          U: [0, 1],
        }.freeze

        ORIENTATIONS_MAP = {
          R: :H,
          L: :H,
          U: :V,
          D: :V
        }

        def calculate_ranges
          orientation = ORIENTATIONS_MAP[direction]
          range_x = [start_position[0], end_position[0]].sort
          range_x = (range_x[0]..range_x[1])
          range_y = [start_position[1], end_position[1]].sort
          range_y = (range_y[0]..range_y[1])
          [orientation, range_x, range_y]
        end

        def calculate_positions(start_position)
          delta = NAVIGATION_MAP[direction].map { |multiplier| multiplier * distance }
          end_position = start_position.map.with_index { |value, index| value + delta[index] }
          [start_position, end_position]
        end

        def parse_path(path)
          info = path.clone
          [info[0].to_sym, info[1, 10].to_i]
        end
      end
    end
  end
end
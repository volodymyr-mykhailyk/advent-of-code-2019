require_relative 'wire_segment'

module Universe
  module Ship
    module Electric
      class Wire
        def initialize(path, starting_coords)
          @segments = build_segments(path.clone, starting_coords)
        end

        def segments
          @segments
        end

        def intersections_with(segment)
          segments.map { |s| s.intersection_with(segment) }.compact
        end

        def build_segments(path, starting_coords)
          return [] if path.empty?
          segment_info = path.shift
          segment = WireSegment.new(segment_info, starting_coords)
          [segment] + build_segments(path, segment.end_position)
        end
      end
    end
  end
end
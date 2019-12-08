module Universe
  module Ship
    module Navigation
      class CelestialBody
        def initialize(name)
          @name = name
          @satellites = {}
        end

        def add_satellite(body)
          @satellites[body.name] = body
        end

        def satellites
          @satellites
        end

        def name
          @name
        end

        def draw_map(prefix = '')
          result = ""
          result += prefix + "#{name}"
          result += "\n" if satellites.any?
          result += @satellites.each_value.map do |object|
            object.draw_map(' ' * prefix.length + '|--')
          end.join("\n")
          result
        end

        def orbit_length(depth = 0)
          return depth if satellites.none?

          depth + satellites.each_value.sum { |satellite| satellite.orbit_length(depth + 1) }
        end

        def to_s
          satellites_info = @satellites.each_value.map(&:to_s).join("\n")
          "#{'----' * 10}\n#{name}: #{satellites_info}"
        end
      end
    end
  end
end
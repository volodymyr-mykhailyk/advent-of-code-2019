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
          result = prefix + "#{name}"
          result += "\n" if satellites.any?
          result + @satellites.each_value.map do |object|
            object.draw_map(prefix + '--')
          end.join("\n")
        end

        def orbits_length(depth = 0)
          return depth if satellites.none?

          depth + satellites.each_value.sum { |satellite| satellite.orbits_length(depth + 1) }
        end

        def has_satellite?(name)
          !!@satellites[name]
        end

        def path_to(object)
          return [] if @satellites.include?(object)
          next_transfer = satellites.values.find { |satellite| satellite.orbital_center_for?(object) }
          ["#{name}-#{next_transfer.name}"] + next_transfer.path_to(object)
        end

        def orbital_center_for?(object)
          return true if satellites.include?(object)

          satellites.values.any? { |satellite| satellite.orbital_center_for?(object) }
        end

        def to_s
          satellites_info = @satellites.each_value.map(&:to_s).join("\n")
          "#{'----' * 10}\n#{name}: #{satellites_info}"
        end
      end
    end
  end
end
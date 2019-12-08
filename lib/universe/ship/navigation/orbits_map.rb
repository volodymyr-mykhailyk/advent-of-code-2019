require_relative 'celestial_body'

module Universe
  module Ship
    module Navigation
      class OrbitsMap
        def initialize(map)
          @objects_pointers = {}
          build_orbits_map(map)
          @roots = find_root_objects
        end

        def checksum
          @roots.each do |body|
            puts "---" * 10
            puts body.draw_map
          end
          puts @roots.inspect
          @roots.sum(&:orbit_length)
        end

        protected

        def build_celestial_body(center)
          return @objects_pointers[center] if @objects_pointers[center]

          @objects_pointers[center] = CelestialBody.new(center)
        end

        def build_orbits_map(map)
          map.each do |info|
            center, satellite = info.split(')')
            center_body = build_celestial_body(center)
            satellite_body = build_celestial_body(satellite)
            center_body.add_satellite(satellite_body)
          end
        end

        def find_root_objects
          @objects_pointers.select do |name, _|
            @objects_pointers.none? do |parent, parent_body|
              next if parent == name
              parent_body.satellites.include?(name)
            end
          end.values
        end
      end
    end
  end
end
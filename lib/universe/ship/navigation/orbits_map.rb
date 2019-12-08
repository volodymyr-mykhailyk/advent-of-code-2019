require_relative 'celestial_body'

module Universe
  module Ship
    module Navigation
      class OrbitsMap
        def initialize(map)
          @objects_pointers = {}
          build_orbits_map(map)
          @root = find_root_object
        end

        def checksum
          @root.orbits_length
        end

        def draw_map
          @roots.each do |body|
            puts "---" * 10
            puts body.draw_map
          end
        end

        def shortest_transfer_between(body1, body2)
          central_transfer_to_1 = @root.path_to(body1)
          central_transfer_to_2 = @root.path_to(body2)
          uniq_transfers_1 = central_transfer_to_1.reject { |transfer| central_transfer_to_2.include?(transfer) }
          uniq_transfers_2 = central_transfer_to_2.reject { |transfer| central_transfer_to_1.include?(transfer) }
          uniq_transfers_1 + uniq_transfers_2
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

        def find_root_object
          root_objects = @objects_pointers.select do |name, _|
            @objects_pointers.none? do |parent, parent_body|
              next if parent == name
              parent_body.satellites.include?(name)
            end
          end.values

          raise "Invalid orbital map. Too many root objects #{root_objects.map(&:name)}" if root_objects.length > 1

          root_objects.first
        end
      end
    end
  end
end
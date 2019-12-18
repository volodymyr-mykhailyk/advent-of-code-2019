require_relative '../traversing/visible_objects'

module Universe
  module Navigation
    module Algorithms
      class VisibleObjects
        def initialize(map)
          @map = map
          @visible_objects = visible_objects_for(map)
        end

        def calculate_from_position(position)
          @visible_objects.count
        end

        protected

        def visible_objects_for(map)
          traverser = Navigation::Traversing::VisibleObjects.new(map)
          traverser.to_a
        end
      end
    end
  end
end
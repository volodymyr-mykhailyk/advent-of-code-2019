module Universe
  module Navigation
    module Traversing
      class VisibleObjects
        include Enumerable

        def initialize(map)
          @map = map
        end

        def each(&block)
          @map.each do |object|
            next unless object.visible?
            block.call(object)
          end
        end
      end
    end
  end
end
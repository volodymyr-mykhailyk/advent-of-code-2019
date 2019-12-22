module Universe
  module Navigation
    module Traversing
      class SolidObjects
        include Enumerable

        def initialize(map)
          @map = map
        end

        def each(&block)
          @map.each do |object|
            next unless object.solid?
            block.call(object)
          end
        end
      end
    end
  end
end
require_relative 'position'
require_relative 'objects/void'
require_relative 'objects/wall'

module Universe
  module Navigation
    class ObjectsMapFactory
      OBJECTS = [
        Objects::Void,
        Objects::Wall
      ]

      def from_symbol(symbol, x, y)
        raise "Unknown object #{symbol}" unless (object_class = object_class_for(symbol))
        position = Position.new(x, y)
        object_class.new(position)
      end

      def object_class_for(symbol)
        OBJECTS.find { |object_class| object_class.has_symbol?(symbol) }
      end
    end
  end
end
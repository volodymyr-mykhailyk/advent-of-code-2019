module Universe
  module Navigation
    class ObjectsMap
      attr_reader :width, :height, :objects

      def initialize(objects, objects_factory)
        @objects = objects.map.with_index do |row, y|
          row.map.with_index do |object, x|
            objects_factory.from_symbol(object, x, y)
          end
        end
        @width = @objects[0].length
        @height = @objects.length
      end

      def each(&block)
        objects.each do |row|
          row.each do |object|
            block.call(object)
          end
        end
      end

      def at(x, y)
        raise 'Position out of bounds' if out_of_bounds?(x, y)
        objects[y][x]
      end

      def presentation
        objects.map { |row| row.map(&:symbol).join('') }.join("\n")
      end

      protected

      def out_of_bounds?(x, y)
        return true unless (0..width - 1).include?(x)
        return true unless (0..height - 1).include?(y)

        false
      end
    end
  end
end
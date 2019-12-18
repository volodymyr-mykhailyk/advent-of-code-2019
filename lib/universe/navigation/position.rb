module Universe
  module Navigation
    class Position
      attr_reader :pos_x, :pos_y

      def initialize(x, y)
        @pos_x = x
        @pos_y = y
      end
    end
  end
end
module Universe
  module Navigation
    module Objects
      class Abstract
        attr_reader :position

        def initialize(position)
          @position = position
        end

        def symbol
          self.class::SYMBOL
        end

        def visible?
          false
        end

        def self.has_symbol?(symbol)
          symbol == self::SYMBOL
        end

      end
    end
  end
end
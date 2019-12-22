require_relative 'abstract'

module Universe
  module Navigation
    module Objects
      class Wall < Abstract
        SYMBOL = '#'.freeze

        def solid?
          true
        end
      end
    end
  end
end
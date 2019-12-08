module Universe
  module Communication
    module SpaceImageFormat
      class Layer
        def initialize(image, digits, index)
          @image = image
          @digits = digits
          @index = index
        end

        def digits
          @digits
        end

        def digits_count_for(number)
          digits.count(number)
        end
      end
    end
  end
end
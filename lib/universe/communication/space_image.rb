require_relative 'space_image_format/layer'
module Universe
  module Communication
    class SpaceImage
      def initialize(digits, width, height)
        @digits = digits
        @width = width
        @height = height
        split_layers
      end

      def layers
        @layers
      end

      def checksum
        control_layer = layers.min_by { |layer| layer.digits_count_for(0) }
        control_number_1 = control_layer.digits_count_for(1)
        control_number_2 = control_layer.digits_count_for(2)
        control_number_1 * control_number_2
      end

      protected

      def split_layers
        digits = @digits.clone
        layer_size = @width * @height
        layers_count = digits.length / (layer_size)
        @layers = layers_count.times.map do |index|
          layer_digits = digits.shift(layer_size)
          SpaceImageFormat::Layer.new(self, layer_digits, index)
        end
      end
    end
  end
end
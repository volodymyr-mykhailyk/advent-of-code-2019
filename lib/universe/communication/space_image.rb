require_relative 'space_image_format/layer'
module Universe
  module Communication
    class SpaceImage
      attr_reader :width, :height

      def initialize(digits, width, height)
        @digits = digits
        @width = width
        @height = height
        split_layers
      end

      def layers
        @layers
      end

      def visible_image
        @height.times.map do |y|
          @width.times.map do |x|
            visible_pixel_at(x, y)
          end
        end
      end

      def render_image
        visible_image.map do |row|
          row.map { |pixel| PIXEL_PRESENTATIONS[pixel] }.join('')
        end.join("\n")
      end

      def checksum
        control_layer = layers.min_by { |layer| layer.digits_count_for(0) }
        control_number_1 = control_layer.digits_count_for(1)
        control_number_2 = control_layer.digits_count_for(2)
        control_number_1 * control_number_2
      end

      protected

      TRANSPARENT_PIXEL = 2
      PIXEL_PRESENTATIONS = {
        0 => ' ',
        1 => '▓',
        2 => ' '
      }

      def visible_pixel_at(x, y)
        pixels = layers.map { |layer| layer.pixel_at(x, y) }
        pixels.find(&method(:visible_pixel?)) || 2
      end

      def visible_pixel?(value)
        value != TRANSPARENT_PIXEL
      end

      def pixel_presentation(pixel)
        return "&x25A1;" if pixel
      end

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
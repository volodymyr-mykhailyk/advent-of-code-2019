module Universe
  module Ship
    module Computer
      class Display
        PIXELS = {
          0 => ' ',
          1 => '█',
          2 => '▓',
          3 => '━',
          4 => '◉',
        }.freeze

        attr_reader :max_x, :max_y, :score

        def initialize
          @display = []
          @max_x = 0
          @max_y = 0
          @score = 0
        end

        def render(instructions)
          instructions.each_slice(3) do |x, y, pixel|
            set_pixel(x, y, pixel)
          end
        end

        def set_pixel(x, y, pixel)
          return set_score(pixel) if score_instruction?(x, y)
          update_resolution(x, y)
          row(y)[x] = pixel
        end

        def set_score(score)
          @score = score
        end

        def score_instruction?(x, y)
          x == -1 && y == 0
        end

        def screen
          "Score: #{score}\n" + @display.map { |row| render_row(row) }.join("\n")
        end

        def pixels_count(pixel)
          @display.sum { |row| row.count(pixel) }
        end

        def pixel_location(pixel)
          y = @display.find_index { |row| row.include?(pixel) }
          [row(y).find_index(pixel), y]
        end

        private

        def render_row(row)
          row.map { |pixel| PIXELS[pixel] }.join('')
        end

        def update_resolution(x, y)
          @max_x = [max_x, x].max
          @max_y = [max_y, y].max
        end

        def row(y)
          @display[y] ||= []
        end
      end
    end
  end
end
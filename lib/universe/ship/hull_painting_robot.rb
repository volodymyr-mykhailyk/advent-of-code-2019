require_relative 'intcode_computer'

module Universe
  module Ship
    class HullPaintingRobot
      DIRECTIONS = [:U, :R, :D, :L]
      MOVEMENTS = {U: [0, -1], R: [1, 0], D: [0, 1], L: [-1, 0]}

      def initialize(program, dimension = 100, starting_color = 0)
        @computer = IntcodeComputer.new(program)
        @map = init_map(dimension)
        @painted_panels = @map.map(&:clone)
        @x, @y, @direction = init_robot(dimension)
        @painted_panels_count = 0
        @map[@y][@x] = starting_color
      end

      def paint_side_panel
        loop do
          @computer.run_program.inspect
          update_robot_state(@computer.output.shift, @computer.output.shift)
          break
        rescue Errors::InputRequired => _
          update_robot_state(@computer.output.shift, @computer.output.shift)
          @computer.add_input([current_color])
        end
      end

      def map
        @map.map(&:clone)
      end

      def painted_panels_count
        @painted_panels.sum { |row| row.count { |panel| panel > 0 } }
      end

      protected

      def current_color
        @map[@y][@x]
      end

      def update_robot_state(color, turn_direction)
        return unless color && turn_direction

        update_color(color)
        update_direction(turn_direction)
        update_movement
      end

      def init_map(dimension)
        dimension.times.map { dimension.times.map { 0 } }
      end

      def init_robot(dimension)
        [dimension / 2, dimension / 2, :U]
      end

      private

      def update_color(color)
        @map[@y][@x] = color
        @painted_panels[@y][@x] += 1
      end

      def update_direction(turn_direction)
        current_direction_position = DIRECTIONS.index(@direction)
        direction_delta = turn_direction == 0 ? -1 : 1
        next_direction_position = (DIRECTIONS.length + current_direction_position + direction_delta) % DIRECTIONS.length
        @direction = DIRECTIONS[next_direction_position]
      end

      def update_movement
        movement = MOVEMENTS[@direction]
        @x += movement[0]
        @y += movement[1]
        raise 'out of bounds' if @x < 0 || @x > @map.length
        raise 'out of bounds' if @y < 0 || @y > @map.length
      end
    end
  end
end
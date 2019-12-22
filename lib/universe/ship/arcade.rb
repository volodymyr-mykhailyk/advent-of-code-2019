require_relative 'intcode_computer'
require_relative 'computer/display'
require_relative 'computer/joystick'

module Universe
  module Ship
    class Arcade
      VSYNC = 60.0

      attr_reader :display, :joystick

      def initialize(game_code, joystick = Computer::Joystick.new)
        @display = Computer::Display.new
        @joystick = joystick
        @computer = IntcodeComputer.new(game_code)
      end

      def start
        loop do
          sleep(1 / VSYNC)
          @computer.run_program
          @display.render(@computer.all_output)
          yield display, joystick if block_given?
          break
        rescue Errors::InputRequired => _
          @display.render(@computer.all_output)
          yield display, joystick if block_given?
          @computer.add_input([@joystick.direction])
        end
      end

      def insert_quarters(count)
        @computer.memory.put_value(0, count)
      end

      def blocks_count
        @display.pixels_count(2)
      end

      def screen
        @display.screen
      end

      def score
        @display.score
      end
    end
  end
end
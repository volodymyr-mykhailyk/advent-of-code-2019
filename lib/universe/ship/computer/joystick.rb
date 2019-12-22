require 'timeout'
require 'io/console'

module Universe
  module Ship
    module Computer
      class Joystick
        def direction
          read_input
        end

        protected

        def read_char
          Timeout.timeout(0.3) do
            STDIN.echo = false
            STDIN.raw!

            input = STDIN.getc.chr
            if input == "\e" then
              input << STDIN.read_nonblock(3) rescue nil
              input << STDIN.read_nonblock(2) rescue nil
            end
          ensure
            STDIN.echo = true
            STDIN.cooked!

            return input
          end
        end

        def read_input
          case read_char
          when "\e[C"
            #puts "RIGHT ARROW"
            1
          when "\e[D"
            #puts "LEFT ARROW"
            -1
          when "\u0003"
            puts 'Control+c'
            raise Errors::EndOfProgram
          else
            0
          end
        end
      end
    end
  end
end
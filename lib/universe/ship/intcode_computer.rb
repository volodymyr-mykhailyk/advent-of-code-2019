require_relative 'errors/end_of_program'

module Universe
  module Ship
    class IntcodeComputer
      MAX_ITERATIONS = 100_000
      OP_CODES = {
        1 => :add_numbers,
        2 => :multiply_numbers,
        99 => :abort_program
      }
      def initialize(state)
        @state = state
        @position = 0
      end

      def run_program
        MAX_ITERATIONS.times { run_command }
        raise 'Infinite loop'
      rescue Errors::EndOfProgram => _
        @state
      end

      def run_command
        next_command.call
        advance_position
        @state
      end

      protected

      def abort_program(*_args)
        raise Errors::EndOfProgram, 'Reached end'
      end

      def advance_position
        @position += 4
      end

      def add_numbers
        input1_address, input2_address, output_address = command_arguments
        result = get_value(input1_address) + get_value(input2_address)
        put_value(output_address, result)
      end

      def multiply_numbers
        input1_address, input2_address, output_address = command_arguments
        result = get_value(input1_address) * get_value(input2_address)
        put_value(output_address, result)
      end

      def next_command
        raise 'Command overflow' unless (command = @state[@position])
        raise 'Unknown command' unless OP_CODES[command]
        method(OP_CODES[command])
      end

      def command_arguments
        raise 'Arguments overflow' unless @state.length >= @position + 3
        @state[@position + 1, 3]
      end

      def get_value(address)
        raise 'Get Overflow' unless (value = @state[address])

        value
      end

      def put_value(address, value)
        raise 'Get Overflow' unless @state[address]

        @state[address] = value
      end
    end
  end
end
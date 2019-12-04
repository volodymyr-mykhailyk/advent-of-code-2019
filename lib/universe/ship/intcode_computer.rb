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

      def initialize(memory)
        @memory = memory
        @pointer = 0
      end

      def run_program
        MAX_ITERATIONS.times { run_instruction }
        raise 'Infinite loop'
      rescue Errors::EndOfProgram => _
        @memory
      end

      def run_instruction
        next_instruction.call
        @memory
      end

      protected

      def abort_program
        raise Errors::EndOfProgram, 'Reached end'
      end

      def unknown_command
        raise 'Unknown command'
      end

      def add_numbers
        input1_address, input2_address, output_address = instruction_parameters(3)
        result = get_value(input1_address) + get_value(input2_address)
        put_value(output_address, result)
        advance_to_next_instruction(3)
      end

      def multiply_numbers
        input1_address, input2_address, output_address = instruction_parameters(3)
        result = get_value(input1_address) * get_value(input2_address)
        put_value(output_address, result)
        advance_to_next_instruction(3)
      end

      def next_instruction
        instruction = get_value(@pointer)
        puts @pointer
        puts instruction
        command_name = OP_CODES[instruction]
        puts command_name.inspect
        method(command_name || :unknown_command)
      end

      def instruction_parameters(arity)
        check_address!(@pointer + arity + 1)
        @memory[@pointer + 1, arity]
      end

      def advance_to_next_instruction(arity)
        @pointer += 1 + arity
      end

      def get_value(address)
        check_address!(address)
        @memory[address]
      end

      def put_value(address, value)
        check_address!(address)
        @memory[address] = value
      end

      def check_address!(address)
        raise 'Memory overflow' if memory_length < address

        true
      end

      def memory_length
        @memory_length ||= @memory.length
      end
    end
  end
end
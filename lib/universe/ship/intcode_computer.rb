require_relative 'errors/end_of_program'
require_relative 'computer/int_memory'
require_relative 'computer/instructions_list'

module Universe
  module Ship
    class IntcodeComputer
      MAX_ITERATIONS = 100_000

      def initialize(memory)
        @memory = Computer::IntMemory.new(memory)
        @instructions = Computer::InstructionsList::ALL.map(&:new)
      end

      def run_program
        MAX_ITERATIONS.times { run_instruction }
        raise 'Infinite loop'
      rescue Errors::EndOfProgram => _
        @memory
      end

      def run_instruction
        next_instruction.execute_in(@memory)
        @memory
      end

      protected

      def unknown_command
        raise 'Unknown command'
      end

      def next_instruction
        @instructions.find { |instruction| instruction.up_next_in?(@memory) } || unknown_command
      end
    end
  end
end
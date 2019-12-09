module Universe
  module Ship
    module Computer
      module Instructions
        class Abstract
          def initialize(computer)
            @computer = computer
          end

          def up_next_in?(memory)
            instruction = memory.get_value(memory.pointer)
            instruction_code = extract_instruction_code(instruction)
            instruction_code == opcode
          end

          def execute_in(memory)
            instruction = memory.get_value(memory.pointer)
            result = execute_instruction(memory, instruction)

            write_output(memory, result) if has_output?
            advance_to_next_instruction(memory) if advancing_pointer?

            memory
          end

          private

          def write_output(memory, result)
            output_address = output_address(memory)
            memory.put_value(output_address, result)
          end

          def advance_to_next_instruction(memory)
            memory.advance_by(1)
            memory.advance_by(arguments_count)
            memory.advance_by(1) if has_output?
          end

          def execute_instruction(memory, instruction)
            arguments = extract_arguments(memory, instruction)
            result_for(*arguments)
          end

          def extract_arguments(memory, instruction)
            pointers = arguments_count.times.map do |argument_position|
              parameter_mode = extract_parameter_mode(instruction, argument_position)
              argument_pointer(memory, argument_position + 1, parameter_mode)
            end

            pointers.map { |pointer| memory.get_value(pointer) }
          end

          def argument_pointer(memory, address_delta, parameter_mode)
            return memory.pointer + address_delta if parameter_mode == 1
            return memory.relative_pointer + memory.get_value(memory.pointer + address_delta) if parameter_mode == 2

            memory.get_value(memory.pointer + address_delta)
          end

          def extract_instruction_code(instruction)
            instruction % 100
          end

          def extract_parameter_mode(instruction, position)
            parameters_spec = instruction / 100
            parameters_spec = parameters_spec / (10 ** position)
            parameters_spec % 10
          end

          def output_address(memory)
            output_offset = 1 + arguments_count
            memory.get_value(memory.pointer + output_offset)
          end
        end
      end
    end
  end
end
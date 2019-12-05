module Universe
  module Ship
    module Computer
      module Instructions
        class Abstract
          def up_next_in?(memory)
            instruction = memory.get_value(memory.pointer)
            instruction_code = extract_instruction_code(instruction)
            instruction_code == opcode
          end

          def execute_in(memory)
            instruction = memory.get_value(memory.pointer)
            output_address = output_address(memory)
            result = execute_instruction(memory, instruction)
            memory.put_value(output_address, result)
            advance_to_next_instruction(memory)
            memory
          end


          private

          def advance_to_next_instruction(memory)
            memory.advance_by(output_offset + 1)
          end

          def execute_instruction(memory, instruction)
            argument_pointers = extract_argument_pointers(memory, instruction)
            arguments = extract_arguments(memory, argument_pointers)
            execute_on_values(*arguments)
          end

          def extract_argument_pointers(memory, instruction)
            instruction_arity.times.map do |argument_position|
              parameter_mode = extract_parameter_mode(instruction, argument_position)
              argument_pointer(memory, argument_position + 1, parameter_mode)
            end
          end

          def extract_arguments(memory, pointers)
            pointers.map { |pointer| memory.get_value(pointer) }
          end

          def argument_pointer(memory, address_delta, parameter_mode)
            return memory.pointer + address_delta if parameter_mode == 1

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
            memory.get_value(output_offset)
          end
        end
      end
    end
  end
end
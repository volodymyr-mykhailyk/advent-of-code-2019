require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class JumpIfTrue < Abstract
          def execute_instruction(memory, instruction)
            input, address = extract_arguments(memory, instruction)
            if input != 0
              memory.advance_to(address)
            else
              advance_to_next_instruction(memory)
            end
          end

          def opcode
            5
          end

          def has_output?
            false
          end

          def advancing_pointer?
            false
          end

          def arguments_count
            2
          end
        end
      end
    end
  end
end
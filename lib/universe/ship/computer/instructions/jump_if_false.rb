require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class JumpIfFalse < Abstract
          def execute_on_values(memory, input, address)
            if input == 0
              memory.advance_to(address)
            else
              advance_to_next_instruction(memory)
            end
          end

          def opcode
            6
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
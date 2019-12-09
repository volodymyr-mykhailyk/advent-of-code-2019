require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class AdjustRelativePointer < Abstract
          def execute_instruction(memory, instruction)
            value = extract_arguments(memory, instruction).first
            memory.advance_relative_by(value)
          end

          def opcode
            9
          end

          def has_output?
            false
          end

          def advancing_pointer?
            true
          end

          def arguments_count
            1
          end
        end
      end
    end
  end
end
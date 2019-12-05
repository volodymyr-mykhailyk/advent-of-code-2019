require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class Output < Abstract
          def execute_instruction(memory, instruction)
            output = extract_arguments(memory, instruction).first
            @computer.put_output(output)
          end

          def opcode
            4
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
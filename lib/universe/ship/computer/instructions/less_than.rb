require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class LessThan < Abstract
          def execute_on_values(_memory, input1, input2)
            input1 < input2 ? 1 : 0
          end

          def opcode
            7
          end

          def has_output?
            true
          end

          def advancing_pointer?
            true
          end

          def arguments_count
            2
          end
        end
      end
    end
  end
end
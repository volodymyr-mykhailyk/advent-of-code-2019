require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class Multiply < Abstract
          def execute_on_values(input1, input2)
            input1 * input2
          end

          def opcode
            2
          end

          def output_offset
            3
          end

          def instruction_arity
            2
          end
        end
      end
    end
  end
end
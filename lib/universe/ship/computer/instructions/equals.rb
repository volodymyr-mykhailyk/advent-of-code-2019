require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class Equals < Abstract
          def result_for(input1, input2)
            input1 == input2 ? 1 : 0
          end

          def opcode
            8
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
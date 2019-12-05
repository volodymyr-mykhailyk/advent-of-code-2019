require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class Add < Abstract
          def result_for(input1, input2)
            input1 + input2
          end

          def opcode
            1
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
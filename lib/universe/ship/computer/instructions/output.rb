require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class Output < Abstract
          def execute_on_values(output)
            @computer.put_output(output)
          end

          def opcode
            4
          end

          def has_output?
            false
          end

          def arguments_count
            1
          end
        end
      end
    end
  end
end
require_relative 'abstract'

module Universe
  module Ship
    module Computer
      module Instructions
        class Input < Abstract
          def execute_on_values(*_args)
            @computer.get_input
          end

          def opcode
            3
          end

          def has_output?
            true
          end

          def arguments_count
            0
          end
        end
      end
    end
  end
end
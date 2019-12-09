require_relative 'abstract'
require_relative '../../errors/input_required'

module Universe
  module Ship
    module Computer
      module Instructions
        class Input < Abstract
          def execute_instruction(*_args)
            raise Errors::InputRequired unless (input = @computer.get_input)

            input
          end

          def opcode
            3
          end

          def has_output?
            true
          end

          def advancing_pointer?
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
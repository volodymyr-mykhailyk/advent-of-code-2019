require_relative 'abstract'
require_relative '../../errors/end_of_program'

module Universe
  module Ship
    module Computer
      module Instructions
        class Exit < Abstract
          def execute_on_values(*_args)
            raise Universe::Ship::Errors::EndOfProgram, 'Program ended'
          end

          def opcode
            99
          end

          def has_output?
            false
          end

          def advancing_pointer?
            false
          end

          def arguments_count
            0
          end
        end
      end
    end
  end
end
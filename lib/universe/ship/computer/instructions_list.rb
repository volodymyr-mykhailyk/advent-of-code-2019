require_relative 'instructions/add'
require_relative 'instructions/multiply'
require_relative 'instructions/exit'

module Universe
  module Ship
    module Computer
      class InstructionsList
        ALL = [
          Instructions::Add,
          Instructions::Multiply,
          Instructions::Exit,
        ]
      end
    end
  end
end
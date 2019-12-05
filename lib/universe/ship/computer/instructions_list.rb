require_relative 'instructions/add'
require_relative 'instructions/multiply'
require_relative 'instructions/exit'
require_relative 'instructions/input'
require_relative 'instructions/output'

module Universe
  module Ship
    module Computer
      class InstructionsList
        ALL = [
          Instructions::Add,
          Instructions::Multiply,
          Instructions::Exit,
          Instructions::Input,
          Instructions::Output,
        ]
      end
    end
  end
end
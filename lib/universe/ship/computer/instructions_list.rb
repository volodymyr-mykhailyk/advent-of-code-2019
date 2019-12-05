require_relative 'instructions/add'
require_relative 'instructions/multiply'
require_relative 'instructions/exit'
require_relative 'instructions/input'
require_relative 'instructions/output'
require_relative 'instructions/less_than'
require_relative 'instructions/equals'
require_relative 'instructions/jump_if_true'
require_relative 'instructions/jump_if_false'

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
          Instructions::LessThan,
          Instructions::Equals,
          Instructions::JumpIfTrue,
          Instructions::JumpIfFalse,
        ]
      end
    end
  end
end
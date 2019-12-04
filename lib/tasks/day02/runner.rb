require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/intcode_computer'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

inputs = input_reader.one_line.split_with(',').to_integer.read
info "Computing program with #{inputs.length} operators"

info "Restoring stack to last working state"
inputs[1] = 12
inputs[2] = 2

computer = Universe::Ship::IntcodeComputer.new(inputs)

output = computer.run_program
info "Program finished. Response #{output[0]}"
require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/intcode_computer'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

program = input_reader.one_line.split_with(',').to_integer.read
info "Computing program with #{program.length} operators"

program_inputs = [1]
computer = Universe::Ship::IntcodeComputer.new(program, program_inputs)

computer.run_program
output = computer.output
info "Program finished. Output #{output}"

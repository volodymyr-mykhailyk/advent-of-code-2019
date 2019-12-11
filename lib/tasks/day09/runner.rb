require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/intcode_computer'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

program = input_reader.one_line.split_with(',').to_integer.read
info "Computing program with #{program.length} operators"

info "Checking intcode computer operations"
computer = Universe::Ship::IntcodeComputer.new(program, [1])
computer.run_program
output = computer.output
info "Selfcheck complete. Diagnostic code: #{output}"

info "Boosting sensors signal"
computer = Universe::Ship::IntcodeComputer.new(program, [2])
computer.run_program
output = computer.output
info "Sensors boosted. Distress coordinates #{output}"

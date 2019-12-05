require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/intcode_computer'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

program = input_reader.one_line.split_with(',').to_integer.read
info "Computing program with #{program.length} operators"

info "Getting diagnostic code for air conditioner"
computer = Universe::Ship::IntcodeComputer.new(program, [1])
computer.run_program
output = computer.output
info "Program finished. Diagnostic code: #{output}"

info "Getting diagnostic code for thermal radiator controller"
computer = Universe::Ship::IntcodeComputer.new(program, [5])
computer.run_program
output = computer.output
info "Program finished. Diagnostic code: #{output}"

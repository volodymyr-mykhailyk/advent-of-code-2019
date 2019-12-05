require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/intcode_computer'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

default_state = input_reader.one_line.split_with(',').to_integer.read
inputs = default_state.clone
info "Computing program with #{inputs.length} operators"

info "Restoring stack to last working state"
inputs[1] = 12
inputs[2] = 2

computer = Universe::Ship::IntcodeComputer.new(inputs)

output = computer.run_program
info "Program finished. Response #{output[0]}"

desired_output = 19690720
info "Brute force program to determine #{desired_output} output"
99.times do |noun|
  99.times do |verb|
    inputs = default_state.clone
    inputs[1] = noun
    inputs[2] = verb
    computer = Universe::Ship::IntcodeComputer.new(inputs)
    output = computer.run_program

    if output[0] == desired_output
      info "Inputs producing #{desired_output} are #{noun}, #{verb}"
      puts "Result answer #{100 * noun + verb}"
    end
  end
end

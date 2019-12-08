require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/amplifiers_chain'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

amplifiers_count = 5
program = input_reader.one_line.split_with(',').to_integer.read
info "Calculating amplifiers phases with #{program.length} operators in controller"

info "Trying out phase combinations"
amplifiers = Universe::Ship::AmplifiersChain.new(program)
possible_phases = amplifiers_count.times.map.to_a

outputs = possible_phases.permutation.map do |phases|
  output = amplifiers.output_for(phases)
  info "Amplifier output for phases #{phases} is: #{output}"
  [phases, output]
end

max_output = outputs.max { |output1, output2| output1.last <=> output2.last }
info "Maximal output #{max_output.last} is reached with phase #{max_output.first}"
require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/amplifiers_chain'
require_relative '../../universe/ship/amplifiers_loop'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

program = input_reader.one_line.split_with(',').to_integer.read
info "Calculating amplifiers phases with #{program.length} operators in controller"

info "Trying out phase combinations for amplifiers chain"
chain_phase_sequence = [0, 1, 2, 3, 4]
amplifiers_chain = Universe::Ship::AmplifiersChain.new(program)

chain_outputs = chain_phase_sequence.permutation.map do |phases|
  output = amplifiers_chain.output_for(phases)
  info "Amplifier output for phases #{phases} is: #{output}"
  [phases, output]
end

max_output = chain_outputs.max { |output1, output2| output1.last <=> output2.last }
info "Maximal chain output #{max_output.last} is reached with phase #{max_output.first}"

info "Trying out phase for amplifiers loops"
loop_phase_sequence = [9, 8, 7, 6, 5]
amplifiers_loop = Universe::Ship::AmplifiersLoop.new(program)
loop_outputs = loop_phase_sequence.permutation.map do |phases|
  output = amplifiers_loop.output_for(phases)
  info "Amplifier output for phases #{phases} is: #{output}"
  [phases, output]
end

max_output = loop_outputs.max { |output1, output2| output1.last <=> output2.last }
info "Maximal loop output #{max_output.last} is reached with phase #{max_output.first}"

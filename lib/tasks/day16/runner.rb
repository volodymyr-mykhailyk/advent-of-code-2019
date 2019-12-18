require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/communication/codecs/flawed_frequency'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))
PATTERN = [0, 1, 0, -1]
PHASES = 100

input = input_reader.one_line.split_with('').to_integer.read
info "Cleaning signal of #{input.length} with FFT"

codec = Universe::Communication::Codecs::FlawedFrequency.new(PATTERN, PHASES)
output = codec.process_signal(input * 10)
info "Processing complete. Result signal start #{output.first(8).join('')}"

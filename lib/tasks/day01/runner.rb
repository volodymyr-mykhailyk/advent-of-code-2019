require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/fuel_counter'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.to_integer.read
info "Calculating fuel for #{input.length} modules"

fuel_counter = Universe::Ship::FuelCounter.new

output = input.sum {|module_mass| fuel_counter.for_module(module_mass) }
info "Total fuel needed #{output}"
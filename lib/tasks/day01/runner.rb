require_relative '../utils/printer'
require_relative '../../common/input_file_reader'
require_relative '../../universe/ship/fuel_counter'

include Utils::Printer

input_reader = Common::InputFileReader.new(File.expand_path('input.txt'))
input = input_reader.as_lines_array.map(&:to_i)
info "Calculating fuel for #{input.length} modules"

fuel_counter = Universe::Ship::FuelCounter.new

output = input.sum {|module_mass| fuel_counter.for_module(module_mass) }
info "Total fuel needed #{output}"
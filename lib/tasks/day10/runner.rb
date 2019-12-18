require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/navigation/objects_map'
require_relative '../../universe/navigation/objects_map_factory'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.split_with('').read
factory = Universe::Navigation::ObjectsMapFactory.new
map = Universe::Navigation::ObjectsMap.new(input, factory)
info "Calculation best asteroid detection on map[#{map.width},#{map.height}]"

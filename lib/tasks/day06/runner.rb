require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/navigation/orbits_map'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input_reader.all_lines.read

map = Universe::Ship::Navigation::OrbitsMap.new(input_reader.all_lines.read)

puts map.checksum

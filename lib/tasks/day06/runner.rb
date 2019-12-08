require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/navigation/orbits_map'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.read
info "Calculating orbital maneuvers with #{input.length} orbits"

map = Universe::Ship::Navigation::OrbitsMap.new(input)

info "Calculating checksum of orbital map"
checksum = map.checksum
info "Checksum of map is: #{checksum}"

info "Calculating optimal transfer between 'YOU' and 'SAN' objects"
orbital_transfers = map.shortest_transfer_between('YOU', 'SAN')
info "Shortest transfer path is: #{orbital_transfers}"
info "Shortest transfer jumps: #{orbital_transfers.length}"

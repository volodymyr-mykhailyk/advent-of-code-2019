require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/wires_panel'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.split_with(',').read
info "Calculating wiring problems with #{input.sum(&:length)} segments"

wire_panel = Universe::Ship::WiresPanel.new
input.each { |path| wire_panel.add_wire(path) }

wires_start = [0, 0]
intersection = wire_panel.closest_intersection_to(wires_start)
distance_to_intersection = wire_panel.distance_between(wires_start, intersection)
info "Closest intersection to start position #{wires_start} is #{intersection}"
info "Distance to closest intersection is: #{distance_to_intersection}"

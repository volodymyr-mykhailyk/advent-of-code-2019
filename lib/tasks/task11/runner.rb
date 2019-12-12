require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/hull_painting_robot'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

program = input_reader.one_line.split_with(',').to_integer.read
info "Painting side panel with #{program.length} hull robot program"

robot = Universe::Ship::HullPaintingRobot.new(program, 100)
robot.paint_side_panel
info "Painting complete. Number of painted panels: #{robot.painted_panels_count}"

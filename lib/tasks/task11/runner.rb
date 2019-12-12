require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/hull_painting_robot'
require_relative '../../universe/communication/space_image'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))
PANEL_DIMENSION = 100

program = input_reader.one_line.split_with(',').to_integer.read
info "Painting side panel with #{program.length} hull robot program"

robot = Universe::Ship::HullPaintingRobot.new(program, PANEL_DIMENSION)
robot.paint_side_panel
info "Painting complete. Number of painted panels: #{robot.painted_panels_count}"

info "Painting side panel with with first panel white"
robot = Universe::Ship::HullPaintingRobot.new(program, PANEL_DIMENSION, 1)
robot.paint_side_panel
info "Painting complete. Number of painted panels: #{robot.painted_panels_count}"
image = Universe::Communication::SpaceImage.new(robot.map.flatten, PANEL_DIMENSION, PANEL_DIMENSION)
info "Rendered license plate:"
puts image.render_image

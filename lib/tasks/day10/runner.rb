require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/navigation/objects_map'
require_relative '../../universe/navigation/objects_map_factory'
require_relative '../../universe/navigation/algorithms/visible_objects'
require_relative '../../universe/navigation/traversing/solid_objects'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.split_with('').read
factory = Universe::Navigation::ObjectsMapFactory.new
map = Universe::Navigation::ObjectsMap.new(input, factory)
info "Calculation best asteroid detection on map[#{map.width},#{map.height}]"
objects_inspector = Universe::Navigation::Algorithms::VisibleObjects.new(map)
asteroids_finder = Universe::Navigation::Traversing::SolidObjects.new(map)
info "Total asteroids #{asteroids_finder.count}"
best_asteroid = asteroids_finder.max_by { |asteroid| objects_inspector.calculate_from_position(asteroid.position) }
info "Discovered best asteroid #{best_asteroid.position}: #{objects_inspector.calculate_from_position(best_asteroid.position)}"
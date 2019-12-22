require 'ostruct'
require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/ship/arcade'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

program = input_reader.one_line.split_with(',').to_integer.read
info "Running arcade with game of #{program.length} length"
arcade = Universe::Ship::Arcade.new(program)
arcade.start
info "Blocks count: #{arcade.blocks_count}"

puts arcade.screen

joystick = OpenStruct.new(direction: 0)
arcade = Universe::Ship::Arcade.new(program, joystick)
info "Press any key to inserting 2 quarters into arcade"
gets
arcade.insert_quarters(2)

def controller(ball, racket)
  return 0 if ball == racket
  ball > racket ? 1 : -1
end

arcade.start do |display, joystick|
  system("clear")
  puts display.screen
  ball_position = display.pixel_location(4)
  racket_position = display.pixel_location(3)
  joystick.direction = controller(ball_position[0], racket_position[0])
  exit if ball_position[1] >= 22
end

info "Game complete. Score: #{arcade.score}"

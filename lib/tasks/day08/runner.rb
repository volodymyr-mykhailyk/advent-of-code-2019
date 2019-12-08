require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/communication/space_image'

include Utils::Printer

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

image_width = 25
image_height = 6
image_digits = input_reader.one_line.split_with('').to_integer.read
info "Analyzing password image of #{image_digits.length} length"

image = Universe::Communication::SpaceImage.new(image_digits, image_width, image_height)
checksum = image.checksum
info "Image has #{image.layers.count} layers"
info "Image checksum: #{checksum}"

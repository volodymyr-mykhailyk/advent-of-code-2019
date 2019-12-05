require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../universe/fuel_station/password_verifier'

input_reader = Utils::InputReader.new(File.expand_path('input1.txt'))

inputs = input_reader.one_line.split_with('-').to_integer.read
info "Calculating passwords for #{inputs}"

password_verifier = Universe::FuelStation::PasswordVerifier.new

output = (inputs[0]..inputs[1]).count { |password| password_verifier.valid?(password) }
info "Passwords count #{output}"
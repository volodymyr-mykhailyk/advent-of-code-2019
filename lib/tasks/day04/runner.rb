require_relative 'input_reader'
require_relative 'passwords_counter'

inputs = Tasks::Day04::InputReader.new.(File.expand_path('input1.txt'))
puts "Calculating passwords for #{inputs}"
output = Tasks::Day04::PasswordsCounter.new.(*inputs)
puts "Passwords count #{output}"
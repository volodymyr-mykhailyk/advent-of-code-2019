require_relative '../common/input_file_reader'
require_relative 'solution'

solution = Day01::Solution.new
input = Common::InputFileReader.new(File.expand_path('input.txt')).as_lines_array.map(&:to_i)
puts solution.total_fuel_for_modules(input)
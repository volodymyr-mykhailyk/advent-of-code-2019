require_relative '../common/input_file_reader'
require_relative 'solution'

module Day02
  class Run
    def call
      solution = Day02::Solution.new
      input = Common::InputFileReader.new(File.expand_path('input.txt')).as_lines_array.map(&:to_i)
      solution.total_fuel_for_modules(input)
    end
  end
end

puts Day02::Run.new.call

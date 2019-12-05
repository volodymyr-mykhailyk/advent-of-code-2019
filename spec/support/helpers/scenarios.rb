require 'yaml'
require 'ostruct'

module Scenarios
  def self.for_each_in(path)
    contents = File.read(File.expand_path("../scenarios/#{path}", __dir__))
    scenarios = YAML.load(contents)
    scenarios.each do |scenario|
      yield OpenStruct.new(scenario)
    end
  end
end
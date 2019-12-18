require 'spec_helper'
require 'universe/communication/codecs/flawed_frequency'

RSpec.describe Universe::Communication::Codecs::FlawedFrequency do
  let(:pattern) { [0, 1, 0, -1] }

  [
    {input: '12345678', phases: 1, output: '48226158'},
    {input: '12345678', phases: 2, output: '34040438'},
    {input: '12345678', phases: 3, output: '03415518'},
    {input: '12345678', phases: 4, output: '01029498'},
    {input: '80871224585914546619083218645595', phases: 100, output: '24176176'},
    {input: '19617804207202209144916044189917', phases: 100, output: '73745418'},
    {input: '69317163492948606335995924319873', phases: 100, output: '52432133'},
  ].each do |input:, phases:, output:|
    it "produces correct signal for '#{input}' input and '#{phases}' phases" do
      codec = described_class.new(pattern, phases)
      digits = input.split('').map(&:to_i)
      signal = codec.process_signal(digits)
      result = signal.first(8).join('')
      expect(result).to eq(output)
    end
  end
end
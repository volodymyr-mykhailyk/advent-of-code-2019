require 'spec_helper'
require 'universe/fuel_station/password_verifier'

RSpec.describe Universe::FuelStation::PasswordVerifier do
  describe '.valid?' do
    VERIFICATIONS = [
      {input: 111111, output: false},
      {input: 112233, output: true},
      {input: 123444, output: false},
      {input: 111122, output: true},
      {input: 223450, output: false},
      {input: 123789, output: false},
      {input: 11111, output: false},
      {input: 1111111, output: false},
    ]

    VERIFICATIONS.each do |input:, output:|
      it "verifies #{input} password" do
        expect(subject.valid?(input)).to eq(output)
      end
    end
  end
end
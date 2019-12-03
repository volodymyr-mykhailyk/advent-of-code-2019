require_relative '../../lib/day01/solution'
require_relative '../../lib/day01/verifications'

RSpec.describe Day01::Solution do
  describe 'fuel_equation' do
    Day01::Verifications.fuel_equation.each do |verification|
      it "works with #{verification}" do
        result = subject.fuel_equation(verification[:input])
        expect(result).to eq(verification[:output])
      end
    end
  end

  describe 'fuel_for_mass' do
    Day01::Verifications.fuel_for_mass.each do |verification|
      it "works with #{verification}" do
        result = subject.fuel_for_mass(verification[:input])
        expect(result).to eq(verification[:output])
      end
    end
  end

  describe 'total_fuel_for_modules' do
    Day01::Verifications.total_fuel_for_modules.each do |verification|
      it "works with #{verification}" do
        result = subject.total_fuel_for_modules(verification[:input])
        expect(result).to eq(verification[:output])
      end
    end
  end
end
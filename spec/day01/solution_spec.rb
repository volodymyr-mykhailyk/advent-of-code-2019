require_relative '../../lib/day01/solution'
require_relative '../../lib/day01/verifications'

RSpec.describe Day01::Solution do
  describe 'module_fuel_requirements' do
    Day01::Verifications.module_fuel_requirements.each do |verification|
      it "works with #{verification}" do
        result = subject.module_fuel_requirements(verification[:input])
        expect(result).to eq(verification[:output])
      end
    end
  end

  describe 'total_fuel_requirements' do
    Day01::Verifications.total_fuel_requirements.each do |verification|
      it "works with #{verification}" do
        result = subject.total_fuel_requirements(verification[:input])
        expect(result).to eq(verification[:output])
      end
    end
  end
end
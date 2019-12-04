require_relative '../../universe/fuel_station/password_verifier'

module Tasks
  module Day04
    class PasswordsCounter
      def initialize
        @verifier = Universe::FuelStation::PasswordVerifier.new
      end
      def call(range_begin, range_end)
        (range_begin..range_end).count do |password|
          @verifier.valid?(password)
        end
      end
    end
  end
end


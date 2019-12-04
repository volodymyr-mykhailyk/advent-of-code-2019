module Universe
  module FuelStation
    class PasswordVerifier
      def valid?(password)
        digits = convert_to_digits(password)

        return false unless valid_length?(digits)
        return false unless increasing_numbers?(digits)
        return false unless repeated_numbers?(digits)
        return false unless has_double_digits?(digits)

        true
      end

      protected

      def convert_to_digits(password)
        password.to_s.split('').map(&:to_i)
      end

      def increasing_numbers?(digits)
        digits.slice(0, 5).each_with_index.all? do |digit, index|
          digit <= digits[index+1]
        end
      end

      def repeated_numbers?(digits)
        digits.uniq.count < 6
      end

      def has_double_digits?(digits)
        digits.uniq.any? do |digit|
          digits.count(digit) == 2
        end
      end

      def valid_length?(digits)
        digits.length == 6
      end
    end
  end
end
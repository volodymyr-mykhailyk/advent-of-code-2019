module Universe
  module Communication
    module Codecs
      class FlawedFrequency
        attr_reader :phases, :pattern

        def initialize(pattern = [0, 0, 0, 0], phases = 100)
          @phases = phases
          @pattern = pattern
        end

        def process_signal(digits)
          phases.times.reduce(digits) do |input, phase|
            process_phase(input)
          end
        end

        protected

        def process_phase(input)
          input_length = input.length
          input_length.times.map do |phase|
            pattern = pattern_for(phase + 1, input_length)
            phased_digits = input.map.with_index { |digit, i| digit * pattern[i] }
            result = digit_for(phased_digits)
            result
          end
        end

        def pattern_for(phase, length)
          phase_pattern = pattern.map { |digit| Array.new(phase, digit) }.flatten.first(length + 1)
          phase_pattern = phase_pattern * (1 + length / phase_pattern.length) if phase_pattern.length <= length
          phase_pattern.shift
          phase_pattern.first(length)
        end

        def digit_for(input)
          (input.reduce(0, &:+)).abs % 10
        end
      end
    end
  end
end
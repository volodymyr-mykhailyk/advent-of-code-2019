require_relative 'intcode_computer'

module Universe
  module Ship
    class AmplifiersChain
      def initialize(code)
        @controller_code = code
      end

      def output_for(phases, input = 0)
        phases.reduce(0) do |amplifier_input, phase|
          controller = IntcodeComputer.new(@controller_code, [phase, amplifier_input])
          controller.run_program
          controller.output.first
        end
      end
    end
  end
end
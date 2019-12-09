require_relative 'intcode_computer'

module Universe
  module Ship
    class AmplifiersLoop
      def initialize(code)
        @controller_code = code
      end

      def output_for(phases, input = 0)
        controllers = initialize_controllers(phases)
        controllers_loop(controllers, 0, input)
      end

      protected

      def controllers_loop(controllers, index, input)
        current_index = index % controllers.length
        current_controller = controllers[current_index % controllers.length]
        current_input = input
        begin
          current_input = execute_controller(current_controller, current_input)
          finish_cycle(controllers, current_index + 1, current_input)
        rescue Errors::InputRequired
          current_input = current_controller.output.shift
          controllers_loop(controllers, current_index + 1, current_input)
        end
      end

      def execute_controller(controller, input)
        controller.add_input([input])
        controller.run_program
        controller.output.shift
      end

      def finish_cycle(controllers, index, input)
        return input if index >= controllers.length
        current_input = execute_controller(controllers[index], input)
        finish_cycle(controllers, index+1, current_input)
      end

      def initialize_controllers(phases)
        phases.map { |phase| IntcodeComputer.new(@controller_code, [phase]) }
      end
    end
  end
end
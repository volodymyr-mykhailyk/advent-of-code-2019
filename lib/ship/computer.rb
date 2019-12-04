module Ship
  class Computer
    OP_CODES = {
      1 => :add_numbers,
      2 => :multiply_numbers,
      99 => :abort
    }
    attr_reader :state, :position

    def initialize(state)
      @state = state
      @position = 0
    end

    def run_program
      loop { run_command }
    end

    def run_command
      next_command.call(*next_arguments)
    end

    protected

    def next_command
      raise 'Command stack overflow' unless (command = state[position])
      raise 'Unknown command' unless OP_CODES[command]
      method(OP_CODES[command])
    end

    def next_arguments
      raise 'Arguments stack overflow' unless state.length < position + 3
      state[position + 1, 3]
    end
  end
end
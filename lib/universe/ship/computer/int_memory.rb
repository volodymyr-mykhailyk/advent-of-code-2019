module Universe
  module Ship
    module Computer
      class IntMemory
        def initialize(memory, pointer = 0, relative_pointer = 0)
          @memory = memory.clone
          @pointer = pointer
          @relative_pointer = relative_pointer
          @memory_size = memory.length
        end

        def get_value(address)
          check_address!(address)
          @memory[address]
        end

        def put_value(address, value)
          check_address!(address)
          @memory[address] = value
        end

        def advance_by(positions)
          check_address!(pointer + positions)

          @pointer += positions
        end

        def advance_relative_by(positions)
          check_address!(relative_pointer + positions)

          @relative_pointer += positions
        end

        def advance_to(address)
          check_address!(address)

          @pointer = address
        end

        def pointer
          @pointer
        end

        def relative_pointer
          @relative_pointer
        end

        def contents
          @memory
        end

        protected

        def check_address!(address)
          raise "Invalid address: #{address}" if address < 0
          raise "Memory overflow. Size: #{@memory_size}, address: #{address}" if @memory_size < address

          true
        end
      end
    end
  end
end
module Universe
  module Ship
    module Computer
      class IntMemory
        def initialize(memory, pointer = 0)
          @memory = memory
          @pointer = pointer
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

        def pointer
          @pointer
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
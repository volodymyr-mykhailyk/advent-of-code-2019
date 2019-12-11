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
          increase_memory(address)

          @memory[address]
        end

        def put_value(address, value)
          check_address!(address)
          increase_memory(address)

          @memory[address] = value
        end

        def advance_by(positions)
          @pointer += positions
        end

        def advance_relative_by(positions)
          @relative_pointer += positions
        end

        def advance_to(address)
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

          true
        end

        def increase_memory(size)
          return if @memory_size > size
          (@memory.length..size).each { |index| @memory[index] = 0 }
          @memory_size = size
        end
      end
    end
  end
end
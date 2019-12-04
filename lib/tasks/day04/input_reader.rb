module Tasks
  module Day04
    class InputReader
      def call(path)
        contents = File.read(path)
        contents.split('-').first(2)
      end
    end
  end
end
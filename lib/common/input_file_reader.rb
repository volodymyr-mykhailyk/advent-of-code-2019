module Common
  class InputFileReader
    def initialize(path)
      @path = path
    end

    def as_lines_array
      file.readlines.map(&:chomp)
    end

    def file
      File.open(@path)
    end
  end
end
# frozen_string_literal: true

module SimpleLogParser
  module DataReaders
    class FileReader
      def initialize(path:)
        @path = path
      end

      def read
        return @read if defined?(@read)

        raise FileNotFound unless File.exist?(path)

        @read = File.foreach(path) do |buffer|
          yield buffer
        end
      end

      private

      attr_reader :path
    end
  end
end

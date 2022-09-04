# frozen_string_literal: true

require_relative './ext/string'

module SimpleLogParser
  class STDLogger
    class << self
      def info(text)
        puts text.blue
      end

      def warn(text)
        puts text.yellow
      end

      def error(text)
        puts text.red
      end
    end
  end
end

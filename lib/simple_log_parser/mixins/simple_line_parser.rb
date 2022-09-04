# frozen_string_literal: true

require_relative '../mixins/ip_utils'

module SimpleLogParser
  module Mixins
    module SimpleLineParser
      include IPUtils

      def parse(line)
        return empty_result if line.nil? || line.empty?
        return empty_result unless ip_v4?(line)

        route, ip = line.split(IP_V4_REGEXP)

        [route.strip.gsub(%r{/$}, ''), ip.strip]
      end

      private

      def empty_result
        []
      end
    end
  end
end

# frozen_string_literal: true

module SimpleLogParser
  module Mixins
    module IPUtils
      IP_V4_REGEXP = /(?<ip>\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b)/.freeze

      def ip_v4?(string)
        string.match?(IP_V4_REGEXP)
      end
    end
  end
end

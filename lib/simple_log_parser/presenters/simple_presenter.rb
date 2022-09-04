# frozen_string_literal: true

require_relative '../std_logger'

module SimpleLogParser
  module Presenters
    module SimplePresenter
      class << self
        def present(output_array)
          output_array.each do |line|
            STDLogger.info(line.join(' '))
          end
        end
      end
    end
  end
end

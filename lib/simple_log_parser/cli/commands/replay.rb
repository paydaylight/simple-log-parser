# frozen_string_literal: true

require 'dry/cli'

require './lib/simple_log_parser'
require_relative './helpers/print_metrics'

module SimpleLogParser
  module CLI
    module Commands
      class Replay < Dry::CLI::Command
        include Helpers::PrintMetrics

        desc 'Replay metrics from previously stored file. Currently supports only files created with PStore.'

        argument :path, required: true, desc: 'Path to PStore file'

        example ['./tmp/logs-1662304993.pstore # Replay metrics from logs-1662304993.pstore']

        def call(path:, **)
          store_wrapper = SimpleLogParser::Stores::PStoreWrapper.new(store_path: path)

          return if store_wrapper.empty?

          metrics = SimpleLogParser::Metrics.new(store: store_wrapper)

          STDLogger.info("Replayed from: #{path}")
          present_metrics(metrics: metrics)
        end
      end
    end
  end
end

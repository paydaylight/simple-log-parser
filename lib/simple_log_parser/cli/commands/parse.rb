# frozen_string_literal: true

require 'dry/cli'

require './lib/simple_log_parser'
require_relative './helpers/print_metrics'

module SimpleLogParser
  module CLI
    module Commands
      class Parse < Dry::CLI::Command
        include Helpers::PrintMetrics

        desc 'Parses logs from specified file and presents metrics about max and unique views. ' \
        'Results are stored in `./tmp/`. ' \
        'Currently supports only PStore manager.'

        argument :path, required: true, desc: 'Path to log file'

        example './sample/webserver.log # Parse sample webserver.log'

        def call(path:, **)
          store = SimpleLogParser::StoreManagers::PStoreManager.call(path: path)

          metrics = SimpleLogParser::Metrics.new(store: store)

          return if metrics.empty?

          present_metrics(metrics: metrics)

          STDLogger.info("\n")
          STDLogger.warn("Results are stored at: #{store.store_path}")
        rescue DataReaders::FileNotFound
          STDLogger.error('File not found')
        end
      end
    end
  end
end

# frozen_string_literal: true

module SimpleLogParser
  module CLI
    module Commands
      module Helpers
        module PrintMetrics
          def present_metrics(metrics:)
            STDLogger.warn("Routes sorted by max views:\n")
            metrics.present_max_views

            STDLogger.info("\n")

            STDLogger.warn("Routes sorted by unique views:\n")
            metrics.present_unique_views
          end
        end
      end
    end
  end
end

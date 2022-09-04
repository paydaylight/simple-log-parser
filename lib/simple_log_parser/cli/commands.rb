# frozen_string_literal: true

require 'dry/cli'

require_relative './commands/parse'
require_relative './commands/replay'

module SimpleLogParser
  module CLI
    module Commands
      extend Dry::CLI::Registry

      register 'parse', Parse
      register 'replay', Replay
    end
  end
end

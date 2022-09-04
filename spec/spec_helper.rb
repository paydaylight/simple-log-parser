# frozen_string_literal: true

require 'simple_log_parser'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

# Disable class extensions to easily match stdout
class String
  def colorize(...)
    self
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

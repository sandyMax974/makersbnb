ENV['RACK_ENV'] = 'test'

require './app'
require 'pg'
require 'rspec'
require 'capybara/rspec'
require 'setup_test_database'

Capybara.app = MakersBnB

ENV['ENVIRONMENT'] = 'test'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  
  config.before(:each) do
    setup_test_database
  end

end

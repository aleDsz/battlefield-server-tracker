# frozen_string_literal: false

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../config/environment', __dir__)
require 'codecov'
require 'byebug'
require 'dry/monads'
require 'rspec/rails'
require 'valid_attribute'
require 'rspec/active_model/mocks'
require 'rspec/collection_matchers'
require 'rspec/mocks'
require 'shoulda-matchers'
require 'faker'
require 'fabrication'
require 'simplecov'

# Code coverage
SimpleCov.start do
  minimum_coverage 90
  print_error_status
  enable_coverage :branch
  primary_coverage :branch

  formatter SimpleCov::Formatter::SimpleFormatter

  formatter SimpleCov::Formatter::Codecov if ENV['SIMPLECOV']
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
  config.include ValidAttribute::Method
  config.include FactoryBot::Syntax::Methods
  config.include ActiveJob::TestHelper

  # load action view for presenter tests
  config.include ActionView::TestCase::Behavior, file_path: %r{spec/presenters}

  # In RSpec 3, the default behavior is not to infer the spec type from file location
  config.infer_spec_type_from_file_location!

  # Shows the top 10 slowest tests
  config.profile_examples = false

  # config.include ValidAttribute::Method
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Runs before job spec type
  config.before :all do
    ActiveJob::Base.queue_adapter = :test
  end

  config.after :all do
    clear_enqueued_jobs
  end
end

FactoryBot.find_definitions

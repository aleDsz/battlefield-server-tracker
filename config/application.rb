# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

# The main application module
module BattlefieldServerTracker
  class << self
    attr_accessor :encryption_key

    def config
      yield self
    end
  end

  # The main application class
  class Application < Rails::Application
    config.load_defaults 6.1

    config.autoload_paths << Rails.root.join('app/repositories')
    config.eager_load_paths << Rails.root.join('lib')
  end
end

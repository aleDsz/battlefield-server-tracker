# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

# ruby version
ruby '3.0.1'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'connection_pool', '~> 2.2'
gem 'pg', '~> 1.2'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'fabrication', require: false
  gem 'faker'
  gem 'reek'
  gem 'rspec-rails', '4.0.2'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener_web'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-collection_matchers'
  gem 'rspec-mocks'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.5', require: false
  gem 'simplecov', require: false
  gem 'valid_attribute', '~> 2.0.0'
  gem 'webdrivers'
end

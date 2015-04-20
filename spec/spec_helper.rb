$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH << File.expand_path('../support', __FILE__)

# Use Rails 4 by default if you just do 'rspec spec'
ENV['BUNDLE_GEMFILE'] ||= 'gemfiles/rails40.gemfile'

ENV['BUNDLE_GEMFILE'] = File.expand_path(ENV['BUNDLE_GEMFILE'])
require "bundler"
Bundler.setup

ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] = File.expand_path("../dummy/rails-#{ENV['RAILS_VERSION']}", __FILE__)

ENV['RAILS_VERSION'] = "4.0.2"


# Create the test app if it doesn't exists
unless File.exists?(ENV['RAILS_ROOT'])
  system 'rake setup'
end

require 'rails/all'
require File.expand_path("#{ENV['RAILS_ROOT']}/config/environment.rb",  __FILE__)

puts "Testing with Rails #{Rails::VERSION::STRING} and Ruby #{RUBY_VERSION}"

require 'rspec/rails'
require 'capybara/rails'
require 'factory_girl_rails'
require "awesome_print"
require 'json_spec'

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.use_transactional_fixtures = true
  config.include JsonSpec::Helpers

  def json(body)
  	JSON.parse(body)
  end

end
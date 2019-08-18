ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('Environment is in production mode!') if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  config.filter_rails_from_backtrace!
  config.fixture_path = Rails.root.join('spec', 'fixtures')

end

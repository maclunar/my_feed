ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('Environment is in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!

  filters = []

  # Twitter
  filters += %w[
    TWITTER_ACCESS_TOKEN
    TWITTER_ACCESS_TOKEN_SECRET
    TWITTER_ACCOUNT_ID
    TWITTER_API_KEY
    TWITTER_API_SECRET
    TWITTER_CONSUMER_KEY
    TWITTER_CONSUMER_SECRET
    TWITTER_OAUTH_SECRET
    TWITTER_OAUTH_TOKEN
    TWITTER_OWNER
    TWITTER_OWNER_ID
    TWITTER_CONSUMER_KEY
    TWITTER_CONSUMER_SECRET
    TWITTER_ACCESS_TOKEN
    TWITTER_ACCESS_SECRET
  ]

  # YouTube
  filters << 'YOUTUBE_API_KEY'

  filters.each do |filter|
    c.filter_sensitive_data("<#{filter}>") { ENV[filter] }
  end
end

RSpec.configure do |config|
  config.filter_rails_from_backtrace!
  config.fixture_path = Rails.root.join('spec', 'fixtures')
end

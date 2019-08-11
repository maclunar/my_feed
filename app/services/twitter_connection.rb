class TwitterConnection
  def initialize(tag, page = 1)
    @tag = tag
    @page = page.to_i
  end

  def feed
    client.search("\##{tag}").take(10 * page).collect.map(&:text)
  end

  private

  attr_reader :tag, :page

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end
end

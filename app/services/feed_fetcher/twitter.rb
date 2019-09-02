module FeedFetcher
  class Twitter < Base
    def call
      tweets.map do |tweet|
        {
          source: 'twitter',
          title: tweet.text,
          published_at: tweet.created_at,
          author: tweet.user.name,
          text: tweet.full_text,
          image: tweet.user.profile_image_url.to_s,
          url: tweet.url.to_s
        }
      end
    end

    private

    attr_reader :tag, :page

    def tweets
      @tweets ||= client.search("\##{tag}").take(10 * page)
    end

    def client
      @client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
      end
    end
  end
end

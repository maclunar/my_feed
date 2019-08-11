class FeedGetter
  def initialize(params)
    @tag = params[:tag]
  end

  def feed
    {
      'stackexchange': StackExchangeConnection.new(tag).feed,
      'twitter': TwitterConnection.new(tag).feed,
      'youtube': YouTubeConnection.new(tag).feed
    }
  end

  private

  attr_reader :tag
end

class FeedGetter
  def initialize(params)
    @tag = params[:tag]
  end

  def feeds
    {
      'stackoverflow': StackoverflowConnection.new(tag).feed,
      'twitter': TwitterConnection.new(tag).feed,
      'youtube': YoutubeConnection.new(tag).feed
    }
  end

  private

  attr_reader :tag
end

class FeedGetter
  def initialize(params)
    @tag = params[:tag]
  end

  def feed
    StackExchangeConnection.new(tag).feed
  end

  private

  attr_reader :tag
end

class FeedsController < ApplicationController
  def new; end

  def show
    @feeds = FeedGetter.new(feed_params.to_h).call
  end

  private

  def feed_params
    params.require(:feed).permit(:tag, sources: [:twitter, :stackoverflow, :youtube])
  end
end

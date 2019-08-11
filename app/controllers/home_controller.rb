class HomeController < ApplicationController
  def welcome; end

  def feed
    @feed = FeedGetter.new(feed_params).feed
  end

  private

  def feed_params
    params.permit(:tag)
  end
end

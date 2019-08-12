class HomeController < ApplicationController
  def welcome; end

  def feed
    @feeds = FeedGetter.new(feed_params).feeds
  end

  private

  def feed_params
    params.permit(:tag)
  end
end

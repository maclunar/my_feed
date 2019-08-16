class FeedsController < ApplicationController
  def new; end

  def show
    @feeds = FeedGetter.new(feed_params).feeds
  end

  private

  def permitted_params
    params.permit(:tag, sources: [:twitter, :stackoverflow, :youtube])
  end

  def feed_params
    {
      tag: permitted_params[:tag],
      sources: permitted_params[:sources].to_h.keys
    }
  end
end

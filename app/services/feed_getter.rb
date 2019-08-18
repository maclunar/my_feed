class FeedGetter
  def initialize(params)
    @tag = params[:tag]
    @sources = selected_sources(params[:sources])
  end

  def feeds
    retrieved_feeds = {}

    sources.each do |source|
      retrieved_feeds[source] = retrieve_feed(source)
    end

    retrieved_feeds
  end

  private

  attr_reader :tag, :sources

  def selected_sources(sources_hash)
    sources_hash.select { |_, v| v == '1' }.keys
  end

  def retrieve_feed(source)
    "#{source.capitalize}Connection".constantize.new(tag).feed
  end
end

class FeedGetter
  def initialize(params)
    @tag = params[:tag]
    @sources = selected_sources(params[:sources])
  end

  def call
    retrieved_feeds = {}

    sources.each do |source|
      retrieved_feeds[source] = retrieve_feed(source)
    end

    retrieved_feeds
  end

  private

  attr_reader :tag, :sources

  def selected_sources(sources_hash)
    return {} unless sources_hash

    sources_hash.select { |_, v| v == '1' }.keys
  end

  def retrieve_feed(source)
    "#{source.capitalize}FeedFetcher".constantize.new(tag).call
  end
end

class YouTubeConnection
  def initialize(tag, page = 1)
    @tag = tag
    @page = page.to_i
  end

  def feed
    videos.where(q: tag, max_results: 10 * page)
  end

  private

  attr_reader :tag, :page

  def videos
    @videos ||= Yt::Collections::Videos.new
  end
end

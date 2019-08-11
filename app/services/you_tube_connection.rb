class YouTubeConnection
  def initialize(tag, page = 1)
    @tag = tag
    @page = page.to_i
  end

  def feed
    videos.map do |video|
      {
        source: 'youtube',
        title: video.title,
        published_at: video.published_at,
        author: video.channel_title,
        text: video.description,
        image: video.thumbnail_url('medium'),
        url: 'https://youtu.be/' + video.id
      }
    end
  end

  private

  attr_reader :tag, :page

  def videos
    configure_api_key
    @videos ||= Yt::Collections::Videos.new.where(q: tag, max_results: 10 * page)
  end

  def configure_api_key
    Yt.configuration.api_key = ENV['YOUTUBE_API_KEY']
  end
end

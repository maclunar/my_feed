class StackoverflowConnection < BaseConnection
  def feed
    questions.map do |question|
      {
        source: 'stackoverflow',
        title: question[:title],
        published_at: Time.zone.at(question[:creation_date]),
        author: question[:owner][:display_name],
        text: question[:title],
        image: question[:owner][:profile_image],
        url: question[:link]
      }
    end
  end

  private

  attr_reader :tag, :page

  def questions
    @questions ||= HTTParty.get(search_url, query: query).deep_symbolize_keys[:items]
  end

  def search_url
    'https://api.stackexchange.com/2.2/search'
  end

  def query
    { site: 'stackoverflow', tagged: tag, page: page, pagesize: 10 }
  end
end

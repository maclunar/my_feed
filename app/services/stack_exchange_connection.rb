class StackExchangeConnection
  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(tag, page = 1)
    @tag = tag
    @page = page
  end

  def feed
    questions.map do |question|
      {
        source: 'stackoverflow',
        title: question[:title],
        published_at: Time.at(question[:creation_date]),
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
    @questions ||=  self.class.get('/2.2/questions', options).deep_symbolize_keys[:items]
  end

  def options
    @options ||= { query: { site: 'stackoverflow', page: page } }
  end
end

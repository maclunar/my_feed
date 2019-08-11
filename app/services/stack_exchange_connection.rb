class StackExchangeConnection
  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(tag, page = 1)
    @tag = tag
    @page = page
  end

  def feed
    self.class.get("/2.2/questions", options)
  end

  private

  attr_reader :tag, :page

  def options
    @options ||= { query: { site: 'stackoverflow', page: page } }
  end
end

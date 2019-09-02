module FeedFetcher
  class Base
    class NotImplementedInSubclass < StandardError; end
    def initialize(tag, page = 1)
      @tag = tag
      @page = page.to_i
    end

    def call
      raise NotImplementedInSubclass
    end
  end
end

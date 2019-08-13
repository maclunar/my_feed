class BaseConnection
  class NotImplementedInSubclass < StandardError; end
  def initialize(tag, page = 1)
    @tag = tag
    @page = page.to_i
  end

  def feed
    raise NotImplementedInSubclass
  end
end

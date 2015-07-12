class DuckDuckGoSearcher
  attr_accessor :type
  attr_reader :query

  def initialize(args)
    @type = args[:type]
    @query = args[:query]
  end

  def results
    type.results
  end

  def search
    type.get(query)
  end

  def success?
    type.success?
  end
end

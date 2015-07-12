class DuckDuckGoSearcher
  attr_reader :strategies,
              :query

  def initialize(args)
    @strategies = args[:strategies]
    @query      = args[:query]
  end


  def result
    @result || { infobox: {}, results: [], type: "" }
  end

  def search
    strategies.each do |klass|
      strategy = klass.new
      @result  = strategy.search(query)

      break if @result
    end
  end
end

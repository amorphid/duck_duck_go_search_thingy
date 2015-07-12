require "open-uri"

class GetDdgSearchResultsViaApi
  attr_reader :results

  def get(query)
    uri = URI("https://api.duckduckgo.com/?q=#{query}&format=json&pretty=1")
    @results = JSON.parse(uri.read)
  end

  def success?
    results["Type"] == "A"
  end
end

class DuckDuckGoSearcher
  def fetch_results(query)
    GetDDGSearchResultsViaCapybaraAndNokogiri.new.search(query)
  end

  def results(json)
    json[:results]
  end

  def search(query)
    {
      topic_summary: topic_summary(query),
      results:       results(fetch_results(query))
    }
  end

  def topic_summary(query)
    GetDDGTopicSummaryViaApi.new.search(query)
  end
end

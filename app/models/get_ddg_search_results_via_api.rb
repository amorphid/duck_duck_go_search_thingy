require "open-uri"

class GetDDGSearchResultsViaApi
  attr_reader :response, :uri

  def get_result
    {
      infobox: response["Infobox"],
      results: parse_results,
      type: response["Type"]
    }
  end

  def parse_results
    response["RelatedTopics"].map do |topic|
      a_node = Nokogiri::HTML(topic["Result"]).css("a")

      href = {}
      href[:title] = a_node.children.map { |c| c.text.strip }.join(" ")
      href[:url]   = a_node.attribute("href").value

      description = topic["Text"]

      { href: href, description: description }
    end
  end

  def search(query)
    # set url for API call
    set_uri(query)

    # query the DDG API
    set_response

    #  Response MUST have a topic summary
    return nil unless topic_summary?

    get_result
  end

  def set_response
    @response = JSON.parse(uri.read)
  end

  def set_uri(query)
    @uri = URI("https://api.duckduckgo.com/?q=#{query}&format=json&pretty=1")
  end

  # Response from DDG has topic summaries if it has Type A
  def topic_summary?
    response["Type"] == "A"
  end
end

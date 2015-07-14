require "open-uri"

class GetDDGTopicSummaryViaApi

  public

  def search(query)
    summary_as_json = fetch_summary(uri(query))
    return "" unless summary?(summary_as_json["Type"])
    summary_to_hash(summary_as_json)
  end

  private

  def fetch_summary(uri)
    JSON.parse(uri.read)
  end

  def summary_to_hash(summary)
    {
      description: summary["AbstractText"],
      href: {
        title: summary["Heading"],
        url: summary["AbstractURL"]
      },
      image: summary["Image"]
    }
  end

  def summary?(type)
    type == "A"
  end

  def uri(query)
    URI("https://api.duckduckgo.com/?q=#{query}&format=json&pretty=1")
  end
end


require "open-uri"

class GetDDGSearchResultsViaApi

  public

  def search(query)
    contents_as_json = fetch_contents(uri(query))
    return nil unless topic_summary?(contents_as_json["Type"])
    contents_to_hash(contents_as_json)
  end

  private

  def content_to_hash(content)
    {
      href:        href(href_node(content)),
      description: description(content)
    }
  end

  def contents_to_hash(contents)
    {
      infobox: infobox(contents["Infobox"]),
      results: results(contents["RelatedTopics"]),
      type:    type(contents["Type"])
    }
  end

  def description(content)
    content["Text"]
  end

  def fetch_contents(uri)
    JSON.parse(uri.read)
  end

  def href(node)
    {
      title: href_title(node),
      url:   href_url(node)
    }
  end

  def href_node(content)
    Nokogiri::HTML(content["Result"]).css("a")
  end

  def href_title(node)
    node.children.map { |c| c.text.strip }.join(" ")
  end

  def href_url(node)
    node.attribute("href").value
  end

  def infobox(infobox)
    infobox.empty? ? {} : infobox
  end

  def results(contents)
    contents.map do |content|
      content_to_hash(content)
    end
  end

  def topic_summary?(type)
    type == "A"
  end

  def type(type)
    type.blank? ? "" : type
  end

  def uri(query)
    URI("https://api.duckduckgo.com/?q=#{query}&format=json&pretty=1")
  end
end

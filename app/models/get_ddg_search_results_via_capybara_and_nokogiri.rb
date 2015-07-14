require "capybara/poltergeist"

class GetDDGSearchResultsViaCapybaraAndNokogiri

  public

  def initialize
    initialize_capybara
  end

  def search(query)
    { results: results(query) }
  end

  private

  def content_node(node)
    node.css(".result__a")
  end

  def description(node)
    node.children.map { |c| c.text }.join(" ")
  end

  def description_node(node)
    node.css(".result__snippet")
  end

  def fetch_body(query)
    Capybara.visit "https://www.duckduckgo.com"
    Capybara.fill_in :search_form_input_homepage, with: query
    Capybara.find("#search_button_homepage").click
    Capybara.page.body
  end

  def format_results(nodes)
    nodes.map! do |node|
      {
        href:        href(content_node(node)),
        description: description(description_node(node))
      }
    end
  end

  def href(node)
    {
      title: href_title(node),
      url:   href_url(node)
    }
  end

  def href_title(node)
    node.children.map { |c| c.text.strip }.join(" ")
  end

  def href_url(node)
    node.attribute("href").text
  end

  def initialize_capybara
    Capybara.default_driver = :poltergeist
  end

  def node_is_ad?(node)
    !node.css(".badge--ad").empty?
  end

  def node_is_content?(node)
    !node.css(".result__a").empty?
  end

  def nodes(document)
    document.css(".result")
  end

  def parse_body(body)
    Nokogiri::HTML(body)
  end

  def select_contents(nodes)
    nodes.select { |node| node_is_content?(node) }
  end

  def reject_ads(nodes)
    nodes.reject { |node| node_is_ad?(node) }
  end

  def results(query)
    format_results(
      select_contents(
        reject_ads(
          nodes(
            parse_body(
              fetch_body(
                query
              ))))))
  end

  def type
    ""
  end
end

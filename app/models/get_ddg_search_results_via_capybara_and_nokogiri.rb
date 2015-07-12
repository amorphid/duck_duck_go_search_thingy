class GetDdgSearchResultsViaCapybaraAndNokogiri
  attr_reader :results

  def get(query)
    # we're using Capybara + Poltergeist to scrape the site
    require "capybara/poltergeist"

    # enable Capybara to scrape page with JavaScript
    Capybara.default_driver = :poltergeist

    # visit the DuckDuckGo site
    Capybara.visit "https://www.duckduckgo.com"

    # fill in a search query
    Capybara.fill_in :search_form_input_homepage, with: query

    # submit the query (reponse stored in Capybara.page)
    Capybara.find("#search_button_homepage").click

    # parse the html repsonse into a Nokogiri tree
    parsed_body = Nokogiri::HTML(Capybara.page.body)

    # aggreate results
    #   select non-ads nodes
    #   select nodes w/ valid urls
    results = parsed_body.css(".result").select do |result|
      # non-ad node is missing the .badge--ad
      # we're looking for an empty array, indicating no .badge--ad node
      result.css(".badge--ad").pop.nil? &&

      # node w/ valid url has the .result__a class
      # we're looking for a node within the array
      result.css(".result__a").pop
    end

    # turn each result into a hash containing:
    #   href title
    #   href url
    #   description
    @results = results.map! do |result|
      href_node    = result.css(".result__a")
      desc_node    = result.css(".result__snippet")

      href         = {}
      href[:title] = href_node.children.map { |c| c.text.strip }.join(" ")
      href[:url]   = href_node.attribute("href").text

      description  = desc_node.children.map { |c| c.text }.join(" ")

      { href: href, description: description }
    end
  end
end

















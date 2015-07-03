module Api
  module V1
    class SearchController < ApplicationController
      def index
        search = DuckDuckGoSearcher.new(
          type:  GetDdgSearchResultsViaApi.new,
          query: search_params[:query]
        )
        searcher.search

        unless searcher.success?
          searcher.type = GetDdgSearchResultsViaCapybaraAndNokogiri.new
          searcher.search
        end

        render json: search.results
      end
    end
  end
end

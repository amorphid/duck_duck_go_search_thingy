module Api
  module V1
    class SearchController < ApplicationController
      def index
        searcher = DuckDuckGoSearcher.new(
          type:  GetDdgSearchResultsViaApi.new,
          query: search_params[:q]
        )
        searcher.search

        unless searcher.success?
          searcher.type = GetDdgSearchResultsViaCapybaraAndNokogiri.new
          searcher.search
        end

        render json: searcher.results
      end

      private

      def search_params
        params.permit(:q)
      end
    end
  end
end

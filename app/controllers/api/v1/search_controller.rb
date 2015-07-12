module Api
  module V1
    class SearchController < ApplicationController
      def index
        searcher = DuckDuckGoSearcher.new(
          strategies: [
            GetDDGSearchResultsViaApi,
            GetDDGSearchResultsViaCapybaraAndNokogiri
          ],
          query: search_params[:q]
        )

        searcher.search

        render json: searcher.result
      end

      private

      def search_params
        params.permit(:q)
      end
    end
  end
end

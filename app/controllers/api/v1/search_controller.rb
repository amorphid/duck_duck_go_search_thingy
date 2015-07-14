module Api
  module V1
    class SearchController < ApplicationController
      def index
        searcher = DuckDuckGoSearcher.new
        render json: searcher.search(query)
      end

      private

      def query
        params[:q]
      end
    end
  end
end

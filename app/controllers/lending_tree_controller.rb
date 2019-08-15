class LendingTreeController < ApplicationController
    def fetch_reviews
        lending_tree_parser = LendingTreeParser.new(params[:url])
        reviews = lending_tree_parser.page_iterator
        binding.pry

        render json: {reviews: reviews}, status: status
    end
end

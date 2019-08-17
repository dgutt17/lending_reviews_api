class LendingTreeController < ApplicationController
    before_action :load_business_url

    def fetch_reviews
        if !!@business_url
            reviews = @business_url.reviews
        else
            lending_tree_parser = LendingTreeParser.new(params[:url])
            reviews = lending_tree_parser.page_iterator
            LendingTreeJob.perform_async(reviews, params[:url])
        end

        render json: {reviews: reviews}, status: status
    end

    def load_business_url
        @business_url = BusinessUrl.find_by_url(params[:url])
    end
end

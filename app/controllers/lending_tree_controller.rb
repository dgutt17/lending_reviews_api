class LendingTreeController < ApplicationController
    before_action :check_url_format
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

    private

    def load_business_url
        @business_url = BusinessUrl.find_by_url(params[:url])
    end

    def check_url_format
        url = params[:url].slice(0, 36)
        if url != "https://www.lendingtree.com/reviews/"
            render json: {error_message: "The url you submitted does not begin with 'https://www.lendingtree.com/reviews/'."}, status: 400
        end
    end
end

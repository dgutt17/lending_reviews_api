class BusinessController < ApplicationController
    def fetch_reviews
        business = Business.where(name: params[:name]).first
        reviews = business.reviews

        render json: {reviews: reviews}, status: status
    end

    private 
end

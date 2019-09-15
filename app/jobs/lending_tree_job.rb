class LendingTreeJob
    include Sidekiq::Worker
    sidekiq_options retry: 1

    def perform(reviews, url)
        ActiveRecord::Base.transaction do
            b_url = BusinessUrl.find_or_create_by(url: url)
            reviews.each do |review|
                new_author = Author.find_or_create(review)
                new_review = Review.new(title: review["title"].strip, content: review["text"].strip, total_rating: review["primaryRating"]["value"])
                new_review.author = new_author
                new_review.business_url = b_url
                new_review.review_date = Chronic.parse(review["submissionDateTime"]).beginning_of_day

                new_review.save!
            end
        end
    end
end
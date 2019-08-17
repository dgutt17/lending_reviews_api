class LendingTreeJob
    include Sidekiq::Worker
    sidekiq_options retry: 1

    def perform(reviews, url)
        ActiveRecord::Base.transaction do
            b_url = BusinessUrl.find_or_create_by(url: url)
            reviews.each do |review|
                new_author = Author.find_or_create(review["author"])
                new_review = Review.new(title: review["title"], content: review["content"], total_rating: review["star_rating"])
                new_review.author = new_author
                new_review.business_url = b_url
                # new_review.title = review["title"]
                # new_review.content = review["content"]
                new_review.review_date = review["review_date"].split("in")[1].strip if review["review_date"].present?
                # new_review.total_rating = review["star_rating"]

                new_review.save!
            end
        end
    end
end
FactoryBot.define do 
    factory :review do 
        title "Test"
        content "Hello World! This is so much fun making a review!"
        author
        business_url
        total_rating 4
        review_date "August 2019"
    end
end
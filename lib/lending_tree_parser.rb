require 'nokogiri'
require 'open-uri'

class LendingTreeParser
    attr_accessor :url, :reviews, :doc, :lender_nav_present

    def initialize(url)
        @url = url
        @stored_reviews = []
        @query_string = "?sort=cmV2aWV3c3VibWl0dGVkX2Rlc2M=&pid="
        @no_doc_count = 0
    end

    def page_iterator
        page_num = 1
        while true do
            puts "url: #{@url}#{@query_string}#{page_num}"
            doc = fetching_html_doc("#{@url}#{@query_string}#{page_num}")
            break if !lender_nav_present?(doc) && @no_doc_count >= 10
            reviews = get_reviews(doc)
            html_doc_iterator(reviews)

            page_num += 1
        end

        return @stored_reviews
    end

    private 

    def fetching_html_doc(url)
        doc = Nokogiri::HTML(open(url))

        doc
    end

    def lender_nav_present?(doc)
        lender_nav_present = doc.css(".lenderNav.pagination").present?
        @no_doc_count += 1 if !lender_nav_present

        lender_nav_present
    end

    def get_reviews(doc)
        lender_reviews = doc.css(".lenderReviews")
        main_reviews = lender_reviews.css(".mainReviews")

        main_reviews
    end

    def html_doc_iterator(reviews)
        reviews.each do |elem|
            hash = {}
            hash["star_rating"] = elem.css(".numRec")[0].content[1]
            hash["title"] = elem.css(".reviewTitle")[0].content
            hash["content"] = elem.css(".reviewText")[0].content
            hash["author"] = elem.css(".consumerName")[0].content
            hash["review_date"] = elem.css(".consumerReviewDate")[0].content
            @stored_reviews << hash
        end
    end
end

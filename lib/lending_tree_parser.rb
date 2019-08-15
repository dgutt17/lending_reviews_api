require 'nokogiri'
require 'open-uri'

class LendingTreeParser
    attr_accessor :url, :reviews, :doc

    def initialize(url)
        @url = url
        @initial_doc = Nokogiri::HTML(open(url))
        @stored_reviews = []
    end

    def page_iterator
        index = 0
        reviews = @initial_doc.css(".lenderReviews")
        links = reviews.css(".page-link")
        
        while true do
            if index == links.count - 1
                if links[links.count - 1].content == "Next"
                    doc = Nokogiri::HTML(open(links[links.count - 2].attributes["href"].content))
                    reviews = doc.css(".lenderReviews")
                    links = reviews.css(".page-link")
                    index = 0
                else
                    break
                end
            end

            html_doc_iterator(links[index].attributes["href"].content)

            index += 1
        end

        return @stored_reviews
    end

    private 

    def html_doc_iterator(url)
        puts "url: #{url}"
        doc = Nokogiri::HTML(open(url))
        reviews = doc.css(".lenderReviews")
        reviews.css(".mainReviews").each do |elem|
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
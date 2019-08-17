require 'nokogiri'
require 'open-uri'

class LendingTreeParser
    attr_accessor :url, :reviews, :doc, :lender_nav_present

    def initialize(url)
        @url = url
        # @initial_doc = Nokogiri::HTML(open(url))
        @stored_reviews = []
        @thread_array = []
        @query_string = "?sort=cmV2aWV3c3VibWl0dGVkX2Rlc2M=&pid="
        @lender_nav_present = true
    end

    def page_iterator
        page_num = 1
        # reviews = @initial_doc.css(".lenderReviews")
        # lender_nav = reviews.css(".lenderNav.pagination")
        # links = lender_nav.css(".page-link")
        url_hash = {}
        while true do
            puts "top of loop"
            # if index == links.count - 1
            #     if links[links.count - 1].content == "Next"
            #         doc = Nokogiri::HTML(open(links[links.count - 2].attributes["href"].content))
            #         lender_nav = doc.css(".lenderNav.pagination")
            #         links = lender_nav.css(".page-link")
            #         index = 0
            #     else
            #         html_doc_iterator(links[index].attributes["href"].content)
            #         break
            #     end
            # end

            
            # if !url_hash[links[index].attributes["href"].content]
            #     url_hash[links[index].attributes["href"].content] = true
            puts "page_num: #{page_num}"
            html_doc_iterator("#{@url}#{@query_string}#{page_num}")
            # end

            break if !@lender_nav_present 

            page_num += 1
        end

        return @stored_reviews
    end

    private 

    def html_doc_iterator(url)
        puts "url: #{url}"
        doc = Nokogiri::HTML(open(url))
        @lender_nav_present = doc.css(".lenderNav.pagination").present?
        return if !@lender_nav_present
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
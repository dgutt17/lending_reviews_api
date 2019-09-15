require 'nokogiri'
require 'open-uri'

class LendingTreeParser
    include HTTParty

    attr_accessor :url, :doc, :reviews, :brand_id, :total_reviews, :page_size
                  :response

    def initialize(url)
        @url = url
        @stored_reviews = []
        @api_end_point = "https://www.lendingtree.com/content/mu-plugins/lt-review-api/review-api-proxy.php?brandId="
        @page_size = "&pagesize="
    end

    def retrieve_reviews
        fetching_html_doc
        fetch_brand_id
        fetch_total_reviews
        fetch_reviews

        reviews = JSON.parse(@response)
        reviews = reviews["result"]["reviews"]
        return reviews
    end

    private 

    def fetching_html_doc
        @doc = Nokogiri::HTML(open(@url))
    end

    def fetch_brand_id
       @brand_id = @doc.css(".write-review").first.attributes["data-lenderreviewid"].value
    end

    def fetch_total_reviews
        @total_reviews = @doc.css(".scrolltoreview").first.children.first.text.to_i
    end

    def fetch_reviews
        url = @api_end_point + @brand_id + @page_size + @total_reviews.to_s
        @response = HTTParty.get(url)
    end
end

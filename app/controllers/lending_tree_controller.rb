require 'nokogiri'
require 'open-uri'

class LendingTreeController < ApplicationController
    def fetch_reviews
        binding.pry
        doc2 = Nokogiri::HTML(open(params[:url]))
    end
end

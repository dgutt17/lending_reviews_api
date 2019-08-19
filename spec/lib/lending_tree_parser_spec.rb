require 'rails_helper'
require 'nokogiri'
require 'open-uri'

RSpec.describe LendingTreeParser do
    it "initializes accurately" do 
        lending_tree_parser = LendingTreeParser.new("https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183")

        expect(lending_tree_parser.url).to eql "https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183"
        expect(lending_tree_parser.stored_reviews).to eql []
        expect(lending_tree_parser.query_string).to eql "?sort=cmV2aWV3c3VibWl0dGVkX2Rlc2M=&pid="
        expect(lending_tree_parser.no_doc_count).to eql 0
    end

    context "page_iterator method" do
        it "grabs an html document with a url" do 
            lending_tree_parser = LendingTreeParser.new("https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183")
            doc = lending_tree_parser.send(:fetching_html_doc, "#{lending_tree_parser.url}#{lending_tree_parser.query_string}#{1}")

            expect(doc.class).to eql Nokogiri::HTML::Document
        end

        it "can check if there is navigation panel in the html doc" do 
            lending_tree_parser = LendingTreeParser.new("https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183")
            doc = lending_tree_parser.send(:fetching_html_doc, "#{lending_tree_parser.url}#{lending_tree_parser.query_string}#{1}")
            expect(lending_tree_parser.send(:lender_nav_present?, doc)).to eql true
        end

        it "when no page is returned no navigation panel is found" do 
            lending_tree_parser = LendingTreeParser.new("https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183")
            doc = lending_tree_parser.send(:fetching_html_doc, "#{lending_tree_parser.url}#{lending_tree_parser.query_string}#{300}")
            expect(lending_tree_parser.send(:lender_nav_present?, doc)).to eql false
        end

        it "returns reviews if they exist" do 
            lending_tree_parser = LendingTreeParser.new("https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183")
            doc = lending_tree_parser.send(:fetching_html_doc, "#{lending_tree_parser.url}#{lending_tree_parser.query_string}#{1}")
            reviews = lending_tree_parser.send(:get_reviews, doc)
            lending_tree_parser.send(:html_doc_iterator, reviews)

            expect(lending_tree_parser.stored_reviews.count).to eql 10
        end

        it "returns no reviews if they don't exist" do 
            lending_tree_parser = LendingTreeParser.new("https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183")
            doc = lending_tree_parser.send(:fetching_html_doc, "#{lending_tree_parser.url}#{lending_tree_parser.query_string}#{300}")
            reviews = lending_tree_parser.send(:get_reviews, doc)
            lending_tree_parser.send(:html_doc_iterator, reviews)

            expect(lending_tree_parser.stored_reviews.count).to eql 0
        end
    end
end 
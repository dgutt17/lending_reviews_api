require 'rails_helper'

RSpec.describe Review, type: :model do
    context "Associations" do
        it "belongs to author" do
            association = described_class.reflect_on_association(:author).macro
            expect(association).to eq :belongs_to
        end
        it "belongs to business_url" do 
            association = described_class.reflect_on_association(:business_url).macro
            expect(association).to eq :belongs_to
        end
    end

    context "Validations" do
        let(:review) {create(:review)}
        it "creates a valid review" do 
            expect(review).to be_valid
        end

        xit "is not valid without a title" do 
            review.title = nil
            expect(review).not_to be_valid
        end

        xit "is not valid without content" do 
            review.content = nil
            expect(review).not_to be_valid
        end

        it "is not valid without a business_url" do
            review.business_url = nil
            expect(review).not_to be_valid
        end

        it "is not valid without an author" do
            review.author = nil
            expect(review).not_to be_valid
        end
    end

    context "Instance Methods" do 
        let(:review) {create(:review)}
        it "formats properly when it converts to json" do
            review_json = review.to_json
            review_key_array = JSON.parse(review_json).keys

            expect(review_key_array.length).to eq 5
            expect(review_key_array[0]).to eq "title"
            expect(review_key_array[1]).to eq "content"
            expect(review_key_array[2]).to eq "total_rating"
            expect(review_key_array[3]).to eq "review_date"
            expect(review_key_array[4]).to eq "author"
        end
    end

end
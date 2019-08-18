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

        it "is not valid without a title" do 
            review.title = nil
            expect(review).not_to be_valid
        end

        it "is not valid without content" do 
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

end
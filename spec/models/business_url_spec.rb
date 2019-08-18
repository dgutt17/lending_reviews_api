require 'rails_helper'

RSpec.describe BusinessUrl, type: :model do
  context "Associations" do
    it "has many reviews" do
        association = described_class.reflect_on_association(:reviews).macro
        expect(association).to eq :has_many
    end
  end

  context "Validations" do
    let(:business_url) {create(:business_url)}
    it "creates a valid business_url" do
      expect(business_url).to be_valid
    end

    it "is not valid when the beginnign of the url is not https://www.lendingtree.com/reviews/" do
      business_url.url = "www.lendingtree.com/reviews/personal/first-midwest-bank/52903183"

      expect(business_url).not_to be_valid
    end

    it "is not valid when there is no url" do
      business_url.url = nil
      expect(business_url).not_to be_valid
    end
  end
end

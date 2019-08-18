require 'rails_helper'

RSpec.describe Author, type: :model do
  context "Associations" do
    it "has many reviews" do
        association = described_class.reflect_on_association(:reviews).macro
        expect(association).to eq :has_many
    end
  end
end

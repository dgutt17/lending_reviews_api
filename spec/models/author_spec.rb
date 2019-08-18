require 'rails_helper'

RSpec.describe Author, type: :model do
  context "Associations" do
    it "has many reviews" do
        association = described_class.reflect_on_association(:reviews).macro
        expect(association).to eq :has_many
    end
  end

  context "Class Methods" do 
    let(:author) {create(:author)}

    before do 
      author.save!
    end
    it "creates an author" do
      author = " Jane Doe from Los Angeles "
      new_author = Author.find_or_create(author)
      expect(new_author.name).to eq "Jane Doe"
      expect(new_author.location).to eq "Los Angeles"
    end

    it "finds an author that already exists" do
      author = " Mike Smith  from  Atlanta, GA "
      old_author = Author.find_or_create(author)
      expect(old_author.name).to eq "Mike Smith"
      expect(old_author.location).to eq "Atlanta, GA"
    end
  end
end

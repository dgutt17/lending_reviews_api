class Author < ApplicationRecord
    has_many :reviews

    validates :name, presence: true
    
    def self.find_or_create(review)
        db_author = Author.find_by_name(review["authorName"])
        if !db_author
            db_author = Author.new(name: review["authorName"].strip, location: review["userLocation"].strip)

            db_author.save!
        end

        return db_author
    end
end

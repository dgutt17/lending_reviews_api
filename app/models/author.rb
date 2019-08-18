class Author < ApplicationRecord
    has_many :reviews

    validates :name, presence: true
    
    def self.find_or_create(author)
        author_arr = author.split("from")
        db_author = Author.find_by_name(author_arr[0].strip)
        if !db_author
            db_author = Author.new(name: author_arr[0].strip, location: author_arr[1].strip)

            db_author.save!
        end

        return db_author
    end
end

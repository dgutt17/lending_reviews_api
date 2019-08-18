class BusinessUrl < ApplicationRecord
    has_many :reviews

    validates :url, presence: true
    validate :proper_url_format

    def proper_url_format
        beginning_of_url = self.url.slice(0, 36) if self.url.present?

        if beginning_of_url != "https://www.lendingtree.com/reviews/"
            errors.add(:url, "doesn't start with https://www.lendingtree.com/reviews/")
        end
    end

end

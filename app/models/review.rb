class Review < ApplicationRecord
    belongs_to :business

    validates :title, presence: true
    validates :content, presence: true
end

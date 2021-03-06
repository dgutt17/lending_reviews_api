class Review < ApplicationRecord
    belongs_to :business_url
    belongs_to :author

    # I commented out these validations because some Reviews don't have titles or content
    # validates :title, presence: true
    # validates :content, presence: true

    def as_json(options={})
        super(:only => [:title, :content, :total_rating, :review_date],
              :include => {
                :author => {:only => [:name]},
              }
        )
    end
end

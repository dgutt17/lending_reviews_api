class ChangeReviewDateType < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :review_date, :string
  end
end

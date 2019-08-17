class ChangeNameOfDateOfReview < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :date_of_review, :review_date
  end
end

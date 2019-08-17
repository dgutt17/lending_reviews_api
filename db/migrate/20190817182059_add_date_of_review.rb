class AddDateOfReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :date_of_review, :date
  end
end

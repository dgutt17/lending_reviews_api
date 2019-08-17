class RemoveBusinessIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :business_id
  end
end

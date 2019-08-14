class AddBusinessIndexToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :business_id, :integer, :null => false
    add_index :reviews, :business_id
  end
end

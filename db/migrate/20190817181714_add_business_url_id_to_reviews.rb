class AddBusinessUrlIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :business_url_id, :integer
    add_index :reviews, :business_url_id
  end
end

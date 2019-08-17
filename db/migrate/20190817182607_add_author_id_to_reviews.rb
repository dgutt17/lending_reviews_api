class AddAuthorIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :author_id, :integer
    add_index :reviews, :author_id
  end
end

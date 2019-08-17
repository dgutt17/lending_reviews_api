class AddLocationToAuthor < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :location, :string
  end
end

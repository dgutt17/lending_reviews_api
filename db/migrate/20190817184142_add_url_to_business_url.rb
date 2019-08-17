class AddUrlToBusinessUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :business_urls, :url, :string
  end
end

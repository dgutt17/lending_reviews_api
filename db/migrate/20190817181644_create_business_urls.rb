class CreateBusinessUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :business_urls do |t|

      t.timestamps
    end
  end
end

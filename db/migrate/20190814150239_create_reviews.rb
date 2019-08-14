class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.integer :total_rating
      t.integer :interest_rate_rating
      t.integer :fee_closing_cost_rating
      t.integer :customer_service_rating
      t.integer :responsiveness_rating
      t.boolean :closed_with_lender
      t.boolean :would_recommend_lender

      t.timestamps
    end
  end
end

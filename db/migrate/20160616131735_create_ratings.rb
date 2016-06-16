class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :reviewer_id
      t.integer :reviewed_id
      t.integer :post_id
      t.string :review

      t.timestamps null: false
    end
  end
end

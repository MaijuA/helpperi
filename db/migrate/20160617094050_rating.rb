class Rating < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :post_id
      t.integer :reviewer_id
      t.integer :reviewed_id
      t.float :score
      t.string :review

      t.timestamps null: false
    end
  end

end

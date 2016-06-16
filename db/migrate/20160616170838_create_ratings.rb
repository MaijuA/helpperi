class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.integer :score
      t.string :default => 0

      t.timestamps null: false
    end
  end
end

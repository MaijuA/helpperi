class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :review
      t.integer :user_id
      t.string :role

      t.timestamps null: false
    end
  end
end

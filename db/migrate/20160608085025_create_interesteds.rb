class CreateInteresteds < ActiveRecord::Migration
  def change
    create_table :interesteds do |t|
      t.string :post_id
      t.string :user_id
      t.boolean :denyed

      t.timestamps null: false
    end
  end
end

class AddCommentOnRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :comment, :string
  end
end

class AddDoerToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :doer_id, :integer
  end
end

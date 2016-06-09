class ChangeColumnTypesInCandidates < ActiveRecord::Migration
  def change
    remove_column :candidates, :post_id
    remove_column :candidates, :user_id

    add_column :candidates, :post_id, :integer
    add_column :candidates, :user_id, :integer
  end
end

class ChangeColumnTypesInCandidates < ActiveRecord::Migration
  def change
    change_column :candidates, :post_id, :integer
    change_column :candidates, :user_id, :integer
  end
end

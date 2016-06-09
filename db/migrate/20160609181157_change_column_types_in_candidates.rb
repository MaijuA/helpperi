class ChangeColumnTypesInCandidates < ActiveRecord::Migration
  def change
    change_column :candidates, :post_id, :integer, 'integer USING CAST(post_id AS integer)'
    change_column :candidates, :user_id, :integer, 'integer USING CAST(user_id AS integer)'
  end
end

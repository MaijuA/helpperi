class AddDefaultValueToPostDeleted < ActiveRecord::Migration
  def up
    change_column :posts, :deleted, :boolean, :default => false
  end

  def down
    change_column :posts, :deleted, :boolean
  end
end

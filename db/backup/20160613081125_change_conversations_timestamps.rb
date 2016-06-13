class ChangeConversationsTimestamps < ActiveRecord::Migration
  def change
    change_column :conversations, :created_at, :datetime, null: false
    change_column :conversations, :updated_at, :datetime, null: false
  end
end

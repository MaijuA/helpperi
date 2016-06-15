class AddPostIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :post_id, :integer
  end
end

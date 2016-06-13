class ChangeMessagesTimestamps < ActiveRecord::Migration
  def change
    change_column :messages, :created_at, :datetime, null: false
    change_column :messages, :updated_at, :datetime, null: false
  end
end

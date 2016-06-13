class ChangeColumnNameFromMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :conversations_id, :conversation_id
  end
end

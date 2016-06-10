class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, index: true
      t.references :user, index: true
      t.boolean :read, :default => false
      t.integer :post_id
      t.timestamps
    end
  end
end

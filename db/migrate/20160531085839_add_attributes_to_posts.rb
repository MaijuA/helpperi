class AddAttributesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string
    add_column :posts, :ending_date, :timestamp
    add_column :posts, :address, :string
    add_column :posts, :zip_code, :string
    add_column :posts, :city, :string
    add_column :posts, :radius, :integer
  end
end

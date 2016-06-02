class ChangeDateFormatInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :ending_date, :date
  end
end

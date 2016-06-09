class ChangeInterestedsDenyColumnName < ActiveRecord::Migration
  def change
    rename_column :interesteds, :denyed, :denied
    change_column :interesteds, :denied, :boolean, :default => false
  end
end

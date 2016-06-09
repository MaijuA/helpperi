class RemoveDefaultValueFromCandidates < ActiveRecord::Migration
  def change
    change_column :candidates, :denied, :boolean, :default => nil
  end
end

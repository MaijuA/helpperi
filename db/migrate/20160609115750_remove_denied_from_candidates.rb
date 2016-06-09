class RemoveDeniedFromCandidates < ActiveRecord::Migration
  def change
    remove_column :candidates, :denied
  end
end

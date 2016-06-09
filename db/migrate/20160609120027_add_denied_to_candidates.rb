class AddDeniedToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :denied, :boolean
  end
end

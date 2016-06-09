class ChangeInterestedsTableNameToCandidate < ActiveRecord::Migration
  def change
        rename_table :interesteds, :candidates
  end
end

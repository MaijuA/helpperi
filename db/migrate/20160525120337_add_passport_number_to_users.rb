class AddPassportNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :passport_number, :boolean
  end
end

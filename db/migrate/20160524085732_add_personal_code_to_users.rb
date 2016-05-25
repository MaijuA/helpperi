class AddPersonalCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_code, :string
  end
end

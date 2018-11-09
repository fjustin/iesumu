class AddUserIdToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :user_id, :integer
  end
end

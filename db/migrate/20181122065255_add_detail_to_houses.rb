class AddDetailToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :member, :integer
    add_column :houses, :price, :integer
    add_column :houses, :address, :string
    add_column :houses, :station, :string
  end
end

class RemoveStationFromHouses < ActiveRecord::Migration[5.2]
  def change
    remove_column :houses, :station, :string
  end
end

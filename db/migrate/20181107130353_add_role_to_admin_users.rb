class AddRoleToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :role, :integer, null: false, default: 2
  end
end

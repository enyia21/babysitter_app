class AddUiDsToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :fuid, :integer
    add_column :admins, :guid, :integer
  end
end

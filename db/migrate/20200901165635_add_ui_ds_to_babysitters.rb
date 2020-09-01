class AddUiDsToBabysitters < ActiveRecord::Migration[6.0]
  def change
    add_column :babysitters, :fuid, :integer
    add_column :babysitters, :guid, :integer
  end
end

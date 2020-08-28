class RemoveNameFromBabysitter < ActiveRecord::Migration[6.0]
  def change
    remove_column :babysitters, :name, :string
  end
end

class AddUiDsToParents < ActiveRecord::Migration[6.0]
  def change
    add_column :parents, :fuid, :integer
    add_column :parents, :guid, :integer
  end
end

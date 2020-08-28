class RemoveNameFromParent < ActiveRecord::Migration[6.0]
  def change
    remove_column :parents, :name, :string
  end
end

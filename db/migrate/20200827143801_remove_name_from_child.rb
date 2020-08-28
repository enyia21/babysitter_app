class RemoveNameFromChild < ActiveRecord::Migration[6.0]
  def change
    remove_column :children, :name, :string
  end
end

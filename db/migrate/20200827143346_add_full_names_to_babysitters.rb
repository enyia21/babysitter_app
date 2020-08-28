class AddFullNamesToBabysitters < ActiveRecord::Migration[6.0]
  def change
    add_column :babysitters, :first_name, :string
    add_column :babysitters, :last_name, :string
  end
end

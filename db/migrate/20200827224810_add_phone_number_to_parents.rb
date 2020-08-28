class AddPhoneNumberToParents < ActiveRecord::Migration[6.0]
  def change
    add_column :parents, :phone_number, :integer
  end
end

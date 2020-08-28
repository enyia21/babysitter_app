class ChangeBabysitterIdDataTypeToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :appointments, :babysitter_id, :integer
  end
end

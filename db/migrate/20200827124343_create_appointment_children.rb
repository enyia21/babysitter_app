class CreateAppointmentChildren < ActiveRecord::Migration[6.0]
  def change
    create_table :appointment_children do |t|
      t.integer :appointment_id
      t.integer :child_id

      t.timestamps
    end
  end
end

class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :number_of_children
      t.decimal :appointment_cost
      t.boolean :completed
      t.boolean :babysitter_id

      t.timestamps
    end
  end
end

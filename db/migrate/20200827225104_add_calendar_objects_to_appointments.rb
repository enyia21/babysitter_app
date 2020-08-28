class AddCalendarObjectsToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :date, :datetime
    add_column :appointments, :start_time, :datetime
    add_column :appointments, :end_time, :datetime
  end
end

class RemoveCalendarObjectsFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :date, :date
    remove_column :appointments, :start_time, :time
    remove_column :appointments, :end_time, :time
  end
end

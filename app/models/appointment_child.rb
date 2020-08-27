class AppointmentChild < ApplicationRecord
    belongs_to :appointments
    belongs_to :children
end

class AppointmentChild < ApplicationRecord
    belongs_to :appointment
    belongs_to :child
end

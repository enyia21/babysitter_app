class Review < ApplicationRecord
    belongs_to :parent 
    belongs_to :appointment 

    # i want to return a all reviews where the appointment id 
    scope :reviewed, ->{where("appointment_id = ?", babysitter_appointment)}
end

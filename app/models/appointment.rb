class Appointment < ApplicationRecord
   has_many :appointment_childern
   has_many :children, through: :appointment_children 
   has_one :review
   belongs_to :babysitter
end

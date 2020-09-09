class Appointment < ApplicationRecord
   has_many :appointment_children
   has_many :children, through: :appointment_children 
   has_one :review
   belongs_to :babysitter

   validates :start_time, :end_time, :number_of_children, :appointment_cost, :babysitter_id, presence: true
   validates :number_of_children, numericality: {only_integer: true, greater_than: 0 }
   validate :babysitting_cannot_start_before_it_ends

   scope :babysitter_appointments, -> (babysitter) {where("babysitter_id LIKE ?", babysitter)}
   scope :recent_first, -> { order(:start_time, :desc) }
    
   def babysitting_cannot_start_before_it_ends
      if self.start_time > self.end_time
         errors.add(:start_time, "Start can't be after ending")
      end
   end
      

   COST_PER_HOUR_PER_CHILD = 4.5

   def hours_watched
      ((self.end_time - self.start_time)/3600).round(2) 
   end

   def calculate_appointment_cost
      (self.number_of_children * self.hours_watched * COST_PER_HOUR_PER_CHILD).round(2)
   end
end

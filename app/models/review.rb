class Review < ApplicationRecord
    belongs_to :parent 
    belongs_to :appointment 

    validates :rating, :comment, presence: true
    validates :rating, numericality: {only_integer: true}
    validates :comment, length: {minimum: 25}
    # i want to return a all reviews where the appointment id 
    # scope :reviewed, ->{where("appointment_id = ?", babysitter_appointment)}

    scope :parent_review, -> (parent) {where("parent_id LIKE ?", parent)}
    scope :best_first, -> { order(:created_at, :desc) }
end

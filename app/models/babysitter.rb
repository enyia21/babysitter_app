class Babysitter < ApplicationRecord
    has_many :appointments
    has_many :children, through: :appointments
    has_many :reviews, through: :appointments
    has_secure_password #authenticate  
    def full_name
        "#{self.first_name} #{self.last_name}" 
    end

    def ratings_present?
        self.reviews.present?
    end

end

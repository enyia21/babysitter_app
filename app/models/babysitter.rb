class Babysitter < ApplicationRecord
    has_many :appointments
    has_many :children, through: :appointments
    has_many :reviews, through: :appointments
    has_secure_password #authenticate  
    # password word presence password word length and conformation of password is done automatically by has_secure_password

    validates :first_name, 
              :last_name, 
              :username, 
              :email, presence: true
    validates :phone_number, lenth: { is: 10 }
    validates :phone_number, numericality: { only_integer: true }
    




    def full_name
        "#{self.first_name} #{self.last_name}" 
    end

    def ratings_present?
        self.reviews.present?
    end

end

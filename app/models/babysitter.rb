class Babysitter < ApplicationRecord
    has_many :appointments
    has_many :children, through: :appointments
    has_many :reviews, through: :appointments
    has_secure_password
    
end

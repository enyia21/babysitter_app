class Parent < ApplicationRecord
    has_many :children
    has_many :reviews
    has_many :appointments, through: :children
    has_many :babysitters, through: :appointments
    has_secure_password

    validates :first_name, 
              :last_name, 
              :username, 
              :email, presence: true
    validates :phone_number, length: { is: 10 }
    validates :phone_number, numericality: { only_integer: true }
    validates :username, 
              :email, uniqueness: true

    def full_name
        "#{self.first_name} #{self.last_name}" 
    end
        
end

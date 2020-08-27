class Child < ApplicationRecord
    has_many :appointment_children
    has_many :appointments, through: :appointment_children
    has_many :babysitters, through: :appointments 
    belongs_to :parent 
end

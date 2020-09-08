class Child < ApplicationRecord
    has_many :appointment_children
    has_many :appointments, through: :appointment_children
    has_many :babysitters, through: :appointments 
    belongs_to :parent 

    def full_name
        "#{self.first_name} #{self.last_name}" 
    end

end

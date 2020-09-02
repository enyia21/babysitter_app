class Admin < ApplicationRecord
    has_secure_password

    validates :first_name, 
              :last_name, 
              :username, 
              :email, presence: true
    validates :username, 
              :email, uniqueness: true
end

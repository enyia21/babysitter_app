class Parent < ApplicationRecord
    has_many :children
    has_many :reviews
    has_many :appointments, through: :children
    has_many :babysitters, through: :
    has_secure_password
end

class Review < ApplicationRecord
    belongs_to :parent 
    belongs_to :appointment 
end

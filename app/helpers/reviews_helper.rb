module ReviewsHelper
    def review_home_link
        if user_role == "Admin"
            link_to "Home", parent_appointment_path(@parent, @appointment)
        elsif user_role == "Parent"
            link_to "Home", parent_appointment_path(@parent, @appointment)
        else 
            link_to "Home", babysitter_path(current_user, @appointment)
        end
    end

    def find_reviews_by_user
        if @parent.present?
            parent = @parent.id
            @appointment = Review.parent_review(parent).best_first
        else
            sitter = @babysitter.id
            @appointment = Appointment.babysitter_appointments(sitter)
        end
    end
    
    def rating_ave(babysitter)
        if babysitter.ratings_present?
            total_ratings = 0
            babysitter.reviews.each do |review|
                total_ratings = total_ratings + review.rating
            end
            total_ratings / (babysitter.reviews.count)

        else
            0
        end
    end
end

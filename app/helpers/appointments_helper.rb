module AppointmentsHelper
    
    def appointment_date
        @appointment.start_time.strftime('%A, %B %d, %Y')
    end

    def appointment_home_link
        if user_role == "Admin"
            link_to "Home", admin_path(current_user)
        elsif user_role == "Parent"
            link_to "Home", parent_path(current_user)
        else 
            link_to "Home", babysitter_path(current_user)
        end
    end

    def appointment_edit_link(user, appointment)
        if user_role == "Parent" && !appointment.completed
            link_to "Edit", edit_parent_appointment_path(user, appointment)
        end
    end

    def parent_full_name(appointment)
        parent = get_parent(appointment)
        parent.full_name
    end

    def get_parent(appointment)
        appointment.children.first.parent
    end

    def babysitter_logged_in?
        @babysitter.present?
    end
end

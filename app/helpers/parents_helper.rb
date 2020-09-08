module ParentsHelper
    def parent_home_link
        if user_role == "Admin"
            link_to "Home", admin_path(current_user)
        elsif user_role == "Parent"
            link_to "Home", parent_path(current_user)
        else 
            link_to "Home", babysitter_path(current_user)
        end
    end

    def parent_edit_link(user)
        binding.pry
        if user_role == "Parent"
            link_to "Edit", edit_parent_path(user)
        end
    end
    def user_role
        session[:user_type]
    end

    def current_user
        case session[:user_type]
        when "Admin"
            @current_user ||= Admin.find_by(id: session[:user_id]) if session[:user_id]
        when "Parent"
            @current_user ||= Parent.find_by(id: session[:user_id]) if session[:user_id]
        when "Babysitter"
            @current_user ||= Babysitter.find_by(id: session[:user_id]) if session[:user_id]
        else
            session.clear
        end
    end

    def babysitter_logged_in?
        @babysitter.present?
    end

    def parent_logged_in?
        @parent.present?
    end
end

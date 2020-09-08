class ApplicationController < ActionController::Base

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

    def logged_in?
        current_user.present?
    end

    def direct_to_users_show_page
        if logged_in?
            case session[:user_type]
            when "Admin"
                redirect_to admin_path(current_user) and return
            when "Parent"
                redirect_to parent_path(current_user) and return
            when "Babysitter"
                redirect_to babysitter_path(current_user) and return
            else
                nil
            end
        end
    end

    def isAdmin?
        if session[:user_type] == "Admin"
            true
        else
            false
        end
    end 

    def user_role
        session[:user_type]
    end

    def permitted_parent_or_admin
        session[:user_type].include?("Parent") || isAdmin?
    end

    def permitted_babysitter_or_admin
        session[:user_type].include?("Babysitter") || isAdmin?
    end
end

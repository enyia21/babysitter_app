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
        !!current_user 
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
end

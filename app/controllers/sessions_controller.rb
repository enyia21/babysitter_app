class SessionsController < ApplicationController
    include SessionsHelper
    def new
    end

    def create
        binding.pry
        type_of_user = session_params[:user_type]
        username = session_params[:username]
        if find_user(type_of_user, username).nil?
            flash[:notice] = "Invalid User Name"
            render "new"
        else 
            user = find_user(type_of_user, username)
            if user.authenticate(session_params[:password])
                session[:user_type] = type_of_user
                session[:user_id] = user.id
                binding.pry
                choose_path(type_of_user, user)
            end
        end
    end

    def destroy 
        session.clear
        redirect_to root_path
    end

    private
    def session_params
        params.permit(:username, :password, :user_type)
    end


end

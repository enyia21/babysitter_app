class SessionsController < ApplicationController
    include SessionsHelper
    def new
    end

    def create
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

    def omniauth
        binding.pry
        if !auth.present?
            redirect_to signout_path
        else 
            session[:auth] = auth
            @username = auth[:info][:name]
            @pic = auth[:info][:pic]
        end        
    end
    
    def omniauth_create
        binding.pry
        auth = session[:auth]
        #verify that email is present or return user to home screen
        if auth["info"]["email"].nil?
            redirect_to signout_path and return
        end
        user_email = auth["info"]["email"]
        full_name = auth["info"]["name"].split
        user_type = session_params[:user_type]
        if user_type.include?("Admin") 
            @user = Admin.find_or_create_by(email: user_email) do |u|
                u.first_name = full_name.first
                u.last_name = full_name.last
                u.password = "temp_password"
                u.username ="#{full_name.last} + #{rand{10...30}}"
            end
        elsif user_type.include?("Parent") 
            @user = Parent.find_or_create_by(email: user_email) do |u|
                u.first_name = full_name.first
                u.last_name = full_name.last
                u.password = "temp_password"
                u.username ="#{full_name.last} + #{rand{10...30}}"
            end
        elsif user_type.include?("Babysitter")
            @user= Babysitter.find_or_create_by(email: user_email) do |u|
                u.first_name = full_name.first
                u.last_name = full_name.last
                u.password = "temp_password"
                u.username ="#{full_name.last} + #{rand{10...30}}"
            end
        else
            redirect_to root_path and return
        end
        choose_path(user_type, @user)
    end

    def destroy 
        session.clear
        redirect_to root_path
    end

    private
    def session_params
        params.permit(:username, :password, :user_type)
    end

    def auth
        request.env['omniauth.auth']
    end
end

class SessionsController < ApplicationController
    include SessionsHelper

    def new
    end

    def create
        type_of_user = session_params[:user_type]
        username = session_params[:username]
        if find_user(type_of_user, username).nil?
            # flash[:notice] = "Invalid User Name"
            render "new"
        else 
            user = find_user(type_of_user, username)
            if user.authenticate(session_params[:password])
                session[:user_type] = type_of_user
                session[:user_id] = user.id
                choose_path(type_of_user, user)
            else
                render "new"
            end
        end
    end

    def omniauth
        if !auth.present?
            redirect_to signout_path
        else 
            session[:auth] = auth
            @username = auth["info"]["name"]
            @pic = auth["info"]["pic"]
        end        
    end
    
    def omniauth_create
        auth = session[:auth]
        #create a helper that will find the user by auth[:]
        uid_hash = find_provider(auth)
        user_email = auth["info"]["email"]
        full_name = auth["info"]["name"].split
        user_type = session_params[:user_type]
        if user_type.include?("Admin") 
            @user = Admin.find_or_create_by(uid_hash) do |u|

                u.first_name = full_name.first
                u.last_name = full_name.last
                u.password = "temp_password"
                u.username ="#{full_name.last}" + "#{rand(10...30)}"
                u.email = user_email ||= Faker::Internet.safe_email(name: full_name.last.downcase)
            end
            session[:user_type] =  user_type
            session[:user_id] =  @user.id
        elsif user_type.include?("Parent") 
            @user = Parent.find_or_create_by(uid_hash) do |u|
                u.first_name = full_name.first
                u.last_name = full_name.last
                u.password = "temp_password"
                u.username ="#{full_name.last}" + "#{rand(10...30)}"
                u.email = user_email ||= Faker::Internet.safe_email(name: full_name.last.downcase)
                u.phone_number = "5555555555"
            end
            session[:user_type] =  user_type

            session[:user_id] = @user.id 
        elsif user_type.include?("Babysitter")
            @user= Babysitter.find_or_create_by(uid_hash) do |u|
                u.first_name = full_name.first
                u.last_name = full_name.last
                u.password = "temp_password"
                u.username ="#{full_name.last}" + "#{rand(10...67)}"
                u.email = user_email ||= Faker::Internet.safe_email(name: full_name.last.downcase)
                u.phone_number = "5555555555"
            end
            session[:user_type] =  user_type

            session[:user_id] = @user.id
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

class BabysittersController < ApplicationController
    before_action :find_babysitter, only: [:edit, :update, :show]

    def index
        if logged_in? && isAdmin?
            @babysitters = Babysitter.all
        elsif logged_in?
            direct_to_users_show_page
        else
            redirect_to root_path
        end
    end
    #user wants to create a babysitter the follow the rails
    #new route to babysitter.new after they reach it the are passed to a forme
    #from the from they are passed to...
    def new
        @babysitter = Babysitter.new
    end

    #... create where the strong sitter paramas are passed.  if the 
    # babysitter  passes validation and can be saved the babysitter
    # is created and the user is redirected to the showpage 
    def create 
        @babysitter = Babysitter.new(sitter_params)
        if @babysitter.save
            session[:user_id] = @babysitter.id
            session[:user_type] = "Babysitter"
            redirect_to babysitter_path(@babysitter)
        else
            render "new"
        end
    end
    
    def edit

    end

    def update
        @babysitter.update(sitter_params)
        if @babysitter.save
            redirect_to babysitter_path(@babysitter)
        else 
            render "edit"
        end
    end

    def show 
    end

    private

    def sitter_params
        params.require(:babysitter).permit(
            :first_name,
            :last_name,
            :username,
            :password,
            :password_confirmation,
            :email,
            :phone_number
        )
    end

    def isAdmin?
        if session[:user_type] == "Admin"
            true
        else
            false
        end
    end 

    def find_babysitter
        @babysitter = Babysitter.find_by(id: params[:id])
        if (current_user == @babysitter) || isAdmin?
            @babysitter 
        elsif logged_in? 
            direct_to_users_show_page
        else
            redirect_to root_path and return
        end
    end


end
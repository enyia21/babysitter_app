class ParentsController < ApplicationController
    before_action :find_parent, only: [:edit, :update, :show]

    def index
        if logged_in? && isAdmin?
            @parents =  Parent.all
        elsif logged_in?
            direct_to_users_show_page
        else
            redirect_to root_path
        end

    end

    def new
        @parent = Parent.new
    end

    def create
        @parent = Parent.new(parent_params)
        if @parent.save
            session[:user_id] = @parent.id
            session[:user_type] = "Parent"
            redirect_to parent_path(@parent)
        else
            render "new"
        end
    end

    def edit
    end

    def update 
        @parent.update(parent_params)
        if @parent.save
            redirect_to parent_path(@parent)
        else 
            render "edit"
        end
    end

    def show
    end

    private 

    def parent_params
        params.require(:parent).permit(
            :first_name,
            :last_name,
            :username,
            :password,
            :password_confirmation,
            :email,
            :phone_number
        )
    end
    
 

    def find_parent
        @parent = Parent.find_by(id: params[:id])
        if (current_user == @parent) || isAdmin?
            @parent 
        elsif logged_in? 
            direct_to_users_show_page
        else
            redirect_to root_path and return
        end
    end
end

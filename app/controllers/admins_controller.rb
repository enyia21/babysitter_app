class AdminsController < ApplicationController
    before_action :find_admin, only: [:edit, :update, :show, :destroy]
    def new
        @admin = Admin.new
    end

    def show
    end

    def create
        @admin = Admin.create(admin_params)
        if @admin.save
            session[:user_id] = @admin.id
            session[:user_type] = "Admin"
            redirect_to admin_path(@admin)
        else
            render "new"
        end
    end

    def edit
    end

    def update
    end

    def destroy
        binding.pry
        @admin.destroy
        redirect_to root_path
    end

    private

    def admin_params
        params.require(:admin).permit(
            :first_name,
            :last_name,
            :username,
            :password,
            :password_confirmation,
            :email
        )
    end
    
 

    def find_admin
        @admin = Admin.find_by(id: params[:id])
        if (current_user == @admin)
            @admin 
        elsif logged_in? 
            direct_to_users_show_page
        else
            redirect_to root_path and return
        end
    end
end

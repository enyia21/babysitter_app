class AdminsController < ApplicationController
    def new
        @admin = Admin.new
    end

    def show
        @admin = Admin.find_by(id: params[:id])
        binding.pry
    end

    def create
        # @admin = Admin.create(admin_params)
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
    # def admin

end

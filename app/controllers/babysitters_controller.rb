class BabysittersController < ApplicationController

    def new
        @babysitter = Babysitter.new
    end

    def create 
        @babysitter = Babysitter.new(sitter_params)

    end
    
    def edit
        @babysitter = Babysitter.find_by(id: params[:id])
    end

    def update
        
    end

    def show 
        @babysitter = Babysitter.find_by(id: params[:id])
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
end
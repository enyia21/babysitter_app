class ParentsController < ApplicationController
    def index
    end

    def new
        @parent = Parent.new
    end

    def create
        @parent = Parent.new(parent_params)
    end

    def edit
        @parent = Parent.find_by(id: params[:id])
    end

    def update 
    end

    def show
        @parent = Parent.find_by(id: params[:id])
    end

    
end

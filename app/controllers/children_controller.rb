class ChildrenController < ApplicationController
    before_action :find_parent
    def index
        @children = @parent.children
    end

    def show
        valid_child(@parent)
    end

    def new
        @child = Child.new(parent_id: params[:parent_id])
    end

    def create
        @child = Child.new(child_parent_params)
        if @child.save
            redirect_to parent_child_path(@child.parent, @child)
        else
            render "edit"
        end
    end


    def edit
        valid_child(@parent)
    end

    def update
        valid_child(@parent)
        @child.update(child_parent_params)
        if @child.save
            redirect_to parent_child_path(@parent, @child)
        else
            render "edit"
        end
    end

    def destroy
        valid_child(@parent)
        @child.destroy
        redirect_to parent_path(@parent)
    end

    private

    def child_parent_params
        params.require(:child).permit(
            :first_name,
            :last_name,
            :age, 
            :parent_id
        )
    end

    def isAdmin?
        if session[:user_type] == "Admin"
            true
        else
            false
        end
    end 

    def find_parent
        @parent = Parent.find_by(id: params[:parent_id])
        if (current_user == @parent) || isAdmin?
            @parent 
    
        elsif logged_in? 
            direct_to_users_show_page
        else
            redirect_to root_path and return
        end
    end

    def valid_child(parent)
        @child = Child.find_by(id: params[:id])
        if parent.children.include?(@child)
            @child
        else
            redirect_to parent_children_path(parent)
        end
    end
    
end

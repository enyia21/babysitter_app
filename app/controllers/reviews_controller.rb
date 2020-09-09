class ReviewsController < ApplicationController
    before_action :index_show_by_user_type, only: [:index, :show]
    before_action :find_parent, except: [:index, :show]
    before_action :valid_appointment_belongs_to_user, except: :index
    before_action :verify_review_is_from_appointment, except: [:index, :new, :create]

    def index 
        
    end

    def new
        @review = Review.new(parent_id: params[:parent_id], appointment_id: params[:appointment_id])
    end
    def create
        @review = Review.new(review_params)
        if @review.save 
            redirect_to parent_appointment_review_path(@parent, @appointment, @review)
        else
            render "new"
        end
    end

    def edit
    end

    def update
        @review.update(review_params)
        if @review.save 
            redirect_to parent_appointment_review_path(@parent, @appointment, @review) 
        else
            render "edit"
        end
    end

    def show
        
    end

    def destroy 
        @review.destroy
        redirect_to parent_appointment_path(@parent, @appointment)
    end

    private 

    def review_params
        params.require(:review).permit(
            :rating, 
            :comment,
            :parent_id,
            :appointment_id
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

    def find_babysitter
        @babysitter = Babysitter.find_by(id: params[:babysitter_id])
        if (current_user == @babysitter) || isAdmin?
            @babysitter 
    
        elsif logged_in? 
            direct_to_users_show_page
        else
            redirect_to root_path and return
        end
    end

    #used to pick the type of search function necessary for the code to work

    def index_show_by_user_type
        if params[:babysitter_id].present?
            find_babysitter
        elsif params[:parent_id].present?
            find_parent
        else
            nil
        end
    end
    #=============================================================

    def valid_appointment_belongs_to_user
        @appointment = Appointment.find_by(id: params[:appointment_id])
        parent_or_babysitter = index_show_by_user_type
        if parent_or_babysitter.appointments.include?(@appointment)
            @appointment
        else
            direct_to_users_show_page
        end
    end

    def verify_review_is_from_appointment
        @appointment = Appointment.find_by(id: params[:appointment_id])
        @review = Review.find_by(id: params[:id])
        
        if @appointment.review.present?
            @review
        else 
            direct_to_users_show_page
        end
    end

    def admin_or_user_index_appointments
        parent_or_babysitter = index_show_by_user_type
        if parent_or_babysitter.nil?
            @appointments = Appointment.all
        else
            @appointments = parent_or_babysitter.appointments
        end
    end
end

class AppointmentsController < ApplicationController
    before_action :index_show_by_user_type, only: [:index, :show]
    before_action :admin_or_user_index_appointments, only: :index
    before_action :admin_or_user_show_appointment, only: :show
    before_action :find_parent, except: [:index, :show]
    before_action :valid_appointment_to_edit, only: [:edit, :update]
    def index
    end

    def new
        @appointment = Appointment.new        
    end

    def create
        number_of_children = appointment_params["child_ids"].reject!(&:empty?).count
        @appointment = Appointment.new(appointment_params)
        @appointment[:number_of_children] = number_of_children
        cost = @appointment.calculate_appointment_cost
        @appointment[:appointment_cost] = cost
        if @appointment.save
            redirect_to parent_appointment_path(@parent, @appointment)
        else
            render "new"
        end
    end
    
    def edit
    end

    def update
        @appointment.update(appointment_params)
        if @appointment.save
            redirect_to parent_appointment_path(@parent, @appointment)
        else
            render "edit"
        end
    end

    def show
    end
    
    private

    def appointment_params
        params.require(:appointment).permit(
            :date,
            :start_time,
            :end_time, 
            :completed,
            :babysitter_id,
            :child_ids => []
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

    def admin_or_user_index_appointments
        parent_or_babysitter = index_show_by_user_type
        if parent_or_babysitter.nil?
            @appointments = Appointment.all
        else
            @appointments = parent_or_babysitter.appointments
        end
    end

    def admin_or_user_show_appointment
        parent_or_babysitter = index_show_by_user_type
        @appointment = Appointment.find_by(id: params[:id])
        if parent_or_babysitter.nil? && isAdmin?
            @appointment
        elsif parent_or_babysitter.appointments.include?(@appointment)
            @appointment
        else

        end
    end

    def valid_appointment_to_edit
        @appointment = Appointment.find_by(id: params[:id])
        if @parent.appointments.include?(@appointment)
            @appointment
        else
            redirect_to parent_children_path(@parent)
        end
    end
end

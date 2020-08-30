class AppointmentsController < ApplicationController
    def new
        @appointment = Appointment.new        
    end

    def create
    end
end

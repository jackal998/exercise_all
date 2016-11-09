class EventsController < ApplicationController

before_action :set_event, :only => [:show, :edit, :update]

	def index
		@events = Event.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			flash[:notice] = "event was successfully created"
			redirect_to events_path
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @event.update(event_params)
			flash[:notice] = "event was successfully updated"
			redirect_to event_path(params[:id])
		else
			render :edit
		end
	end

	def destroy
		Event.find(params[:id]).destroy
		flash[:alert] = "event was successfully deleted"
		redirect_to events_path
	end
	private

	def event_params
		params.require(:event).permit(:name, :description)
	end

	def set_event
		@event = Event.find(params[:id])
	end
end
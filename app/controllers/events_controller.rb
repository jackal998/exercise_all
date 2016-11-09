class EventsController < ApplicationController

before_action :set_event, :only => [:show, :edit]

	def index
		@events = Event.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.save

		redirect_to events_path
	end

	def show
	end

	def edit
	end

	def update
		Event.find(params[:id]).update(event_params)

		redirect_to event_path(params[:id])
	end

	def destroy
		Event.find(params[:id]).destroy
		
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

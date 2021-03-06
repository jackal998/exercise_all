class EventsController < ApplicationController

  before_action :authenticate_user!, :except => :index
  before_action :set_event, :only => [:show, :edit, :update]

  def index
		
		if params[:keyword]
			@events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
		else
			@events = Event.all
		end
		sort_by = (params[:order]=="name") ? "name" : "id"
		@events = @events.order(sort_by).page(params[:page]).per(5)

		respond_to do |format|
			format.html # index.html.erb
			format.xml { render :xml => @events.to_xml }
			format.json { render :json => @events.to_json }
			format.atom { @feed_title = "My event list" } # index.atom.builder
		end
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
		respond_to do |format|
			format.html { @page_title = @event.name } # show.html.erb
			format.xml # show.xml.builder
			format.json { render :json => { id: @event.id, name: @event.name }.to_json }
		end
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

	def latest
		@events = Event.order("id DESC").limit(3)
	end

	def bulk_update
		if params[:ids]
			events = Event.find(params[:ids])
			if params[:commit] == "update"

			elsif params[:commit] == "delete"
				events.each{ |e| e.destroy }
			end
		else
			redirect_to events_url
		end
		# events = ids.map{|i| Event.find_by(i)}.compact
	end

	private

	def event_params
		params.require(:event).permit(
			:name, 
			:description, 
			:category_id, 
			:keyword,
			:location_attributes => [:id, :name, :_destroy], 
			:group_ids => [] )
	end

	def set_event
		@event = Event.find(params[:id])
	end
end

Rails.application.routes.draw do

	resources :events do
		resources :attendees, :controller => 'event_attendees'
		resource :location, :controller => 'event_locations'
	end

	root :to => "events#index"
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

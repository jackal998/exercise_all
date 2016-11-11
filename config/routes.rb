Rails.application.routes.draw do

	namespace :admin do
		resources :events
	end

  devise_for :users
	resources :events do
		resources :attendees, :controller => 'event_attendees'
		resource :location, :controller => 'event_locations'
	    collection do
	        get :latest
	        post :bulk_update
	    end
	end

	root :to => "events#index"
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

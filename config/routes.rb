Rails.application.routes.draw do
	namespace :favourite_object do
	  resources :favourites, only: [:index]
	end
end

Rails.application.routes.draw do
	namespace :favourite do
	  resources :favourites, only: [:index]
	end
end

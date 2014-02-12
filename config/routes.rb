Rails.application.routes.draw do
	namespace :favourite_object do
	  resources :favourites, only: [:index]
	  get 'favourites/:target_type/:target_id' => 'favourites#query'
	  put 'favourites/:target_type/:target_id' => 'favourites#update'
	  put 'favourites/:target_type/:target_id/toggle' => 'favourites#toggle'

	end
end

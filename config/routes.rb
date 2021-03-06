FavouriteObject::Engine.routes.draw do
  resources :favourites, only: [:index]
  get 'favourites/:target_type/:target_id' => 'favourites#show'
  put 'favourites/:target_type/:target_id' => 'favourites#update'
  put 'favourites/:target_type/:target_id/toggle' => 'favourites#toggle'
end
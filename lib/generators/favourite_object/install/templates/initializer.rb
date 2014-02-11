FavouriteObject.setup do |config|

  # NotifyUser will call this within NotificationsController to ensure the user is authenticated.
  config.authentication_method = :authenticate_user!

  # NotifyUser will call this within NotificationsController to return the current logged in user.
  config.current_user_method = :current_user

end
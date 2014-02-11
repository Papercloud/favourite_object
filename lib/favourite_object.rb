require "favourite_object/engine"
require "kaminari"
require "active_model_serializers"


module FavouriteObject

	mattr_accessor :authentication_method
	@@authentication_method = nil

	mattr_accessor :current_user_method
	@@current_user_method = nil

	# Used to set up FavouriteObject from the initializer.
	def self.setup
	  yield self
	end
end

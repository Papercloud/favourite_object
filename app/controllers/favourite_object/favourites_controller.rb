class FavouriteObject::FavouritesController < ApplicationController

	before_filter :authenticate!

	def index
		@favourites = FavouriteObject::Favourite.for_owner(@user)
		                                              .order("created_at DESC")
		                                              .limit(30)
		                                              .page(params[:page])

		respond_to do |format|
		  format.html
		  format.json {render :json => @favourites}
		end
	end




	private 
	def authenticate!
	  method(FavouriteObject.authentication_method).call
	  @user = method(FavouriteObject.current_user_method).call
	end
end
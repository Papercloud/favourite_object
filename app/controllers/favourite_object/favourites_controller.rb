class FavouriteObject::FavouritesController < ApplicationController

	before_filter :authenticate!

	def index
		@favourites = FavouriteObject::Favourite.for_owner(@user)
		                                              .order("created_at DESC")
		                                              .limit(30)
		                                              .page(params[:page])

		respond_to do |format|
		  format.html
		  format.json {render :json => @favourites, each_serializer: FavouriteObject::FavouriteSerializer}
		end
	end

	def update
		#endpoint for favouriting an object
		favourite = FavouriteObject::Favourite.where(owner: @user, target_id: params[:target_id], 
			target_type: params[:target_type]).first_or_create
		favourite.toggle
		render :text => "update"
	end

	private 

	def authenticate!
	  method(FavouriteObject.authentication_method).call
	  @user = method(FavouriteObject.current_user_method).call
	end
end
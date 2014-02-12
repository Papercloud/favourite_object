class FavouriteObject::FavouritesController < ApplicationController

	before_filter :authenticate!

	def index
		#only return is_favourited = true                                              
		@favourites = FavouriteObject::Favourite.for_owner(@user)
													  .where(is_favourited: true)
		                                              .order("created_at DESC")
		                                              .limit(30)
		                                              .page(params[:page])
		                                              
		@favourites = @favourites.with_type(params[:type]) if params[:type]

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
		render :text => favourite.is_favourited
	end

	private 

	def authenticate!
	  method(FavouriteObject.authentication_method).call
	  @user = method(FavouriteObject.current_user_method).call
	end
end
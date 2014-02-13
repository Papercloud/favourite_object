class FavouriteObject::FavouritesController < ApplicationController

	before_filter :authenticate!
	#remove before commiting
	skip_before_filter :verify_authenticity_token  

	def index
		#only return is_favourited = true                                              
		@favourites = FavouriteObject::Favourite.for_owner(@user)
													  .where(is_favourited: true)
		                                              .order("created_at DESC")
		                                              .page(params[:page]).per(params[:per_page])
		                                              
		@favourites = @favourites.with_type(params[:type]) if params[:type]

		respond_to do |format|
		  format.html
		  format.json {render :json => @favourites, meta: { pagination: { per_page: @favourites.limit_value, total_pages: @favourites.total_pages, total_objects: @favourites.total_count } }}
		end
	end

	def query
		if params[:third_party] == 'true'	
			@favourite = FavouriteObject::Favourite.where(owner: @user, third_party_id: params[:target_id], 
				third_party_type: params[:target_type], third_party_flag: true).first_or_initialize
		else
			@favourite = FavouriteObject::Favourite.where(owner: @user, target_id: params[:target_id], 
				target_type: params[:target_type]).first_or_initialize
		end	

		render :json => @favourite, root: 'favourite'
	end

	def update
		#endpoint for favouriting an object
		if params[:third_party] == 'true'	
			favourite = FavouriteObject::Favourite.where(owner: @user, third_party_id: params[:target_id], 
				third_party_type: params[:target_type], third_party_flag: true).first_or_initialize
		else
			favourite = FavouriteObject::Favourite.where(owner: @user, target_id: params[:target_id], 
				target_type: params[:target_type]).first_or_initialize
		end	

		favourite.params = params[:data] if params[:data]
		favourite.params = params[:description] if params[:description]

		if params[:favourite] == 'true'
			favourite.is_favourited = true
		else
			favourite.is_favourited = false
		end

		favourite.save

		render :json => favourite, root: 'favourite'
	end

	def toggle
		# toggle for web interface 
		# DOES NOT ACCOUNT FOR THIRDPARTY FAVOURITES YET
		favourite = FavouriteObject::Favourite.where(owner: @user, target_id: params[:target_id], 
			target_type: params[:target_type]).first_or_create
		favourite.toggle
		
		render :json => favourite, root: 'favourite'
	end

	private 

	def authenticate!
		#fix before commiting
	  # method(FavouriteObject.authentication_method).call
	  # @user = method(FavouriteObject.current_user_method).call
	  @user = User.first
	end
end
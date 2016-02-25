module FavouriteObject
	class BaseFavouritesController < ApplicationController
		respond_to :json
		responders :json

		before_filter :authenticate!

		def index
			collection

			respond_to_method(params[:serializer])
		end

		def collection
			@favourites = Favourite.for_owner(@user)
											.where(is_favourited: true).order("created_at DESC")

			@favourites = @favourites.where(target_type: params[:target_type]) if params[:target_type]
			@favourites = @favourites.where(target_id: params[:target_ids]) if params[:target_ids]

			collection_pagination
		end

		def collection_pagination
			@favourites = @favourites.page(params[:page]).per(params[:per_page])
		end

		def respond_to_method(serializer)
			if serializer == 'lite'
				return respond_with @favourites, each_serializer: LiteFavouriteSerializer
			end
			respond_with @favourites
		end

		def show
			@favourite = Favourite.find_with_target(@user, params[:target_id],
				params[:target_type], params[:third_party_flag])

			respond_with @favourite
		end

		def update
			@favourite = Favourite.find_with_target(@user, params[:target_id],
				params[:target_type], params[:third_party_flag])

			@favourite.update(permitted_params[:favourite])

			respond_with @favourite
		end

		def toggle
			# toggle for web interface
			@favourite = Favourite.find_with_target(@user, params[:target_id],
				params[:target_type], params[:third_party_flag])

			@favourite.toggle

			respond_with @favourite
		end

		def meta
		  if action_name == 'index'
		  	{
		  		pagination: {
		  			per_page: @favourites.limit_value,
		  			total_pages: @favourites.total_pages,
		  			total_objects: @favourites.total_count
		  		}
		  	}
		  end
		end

		private

		def permitted_params
		  params.permit(favourite: [
		  	:is_favourited,
		  	:target_id,
		  	:target_type,
		  	:third_party_flag,
		  	:third_party_id,
		  	:third_party_type,
		  	:params
		  ])
		end

		def authenticate!
		  method(FavouriteObject.authentication_method).call
		  @user = method(FavouriteObject.current_user_method).call
		end
	end
end
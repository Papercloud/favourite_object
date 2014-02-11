require 'spec_helper'


describe FavouriteObject::FavouritesController do

	let(:user) { User.create({email: "user@example.com" })}
	let(:arbitrary_object) { ArbitraryObject.create() }
	let(:favourite) { FavouriteObject::Favourite.create(owner: user, target: arbitrary_object) }

	before :each do
	  FavouriteObject::FavouritesController.any_instance.stub(:current_user).and_return(user)
	  FavouriteObject::FavouritesController.any_instance.stub(:authenticate_user!).and_return(true)
	end

  	describe "favourites" do
  		before :each do
  			favourite.save
  		end
  		it "displays favourites as json" do
  			get :index, format: :json
  			ap response.body
  		end
	end


end
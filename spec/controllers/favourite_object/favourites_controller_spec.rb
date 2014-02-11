require 'spec_helper'


describe FavouriteObject::FavouritesController do

	let(:user) { User.create({email: "user@example.com" })}
	let(:arbitrary_object) { ArbitraryObject.create() }

	before :each do
	  FavouriteObject::FavouritesController.any_instance.stub(:current_user).and_return(user)
	  FavouriteObject::FavouritesController.any_instance.stub(:authenticate_user!).and_return(true)
	end

  	describe "listing favourites" do
  		let(:favourite) { FavouriteObject::Favourite.create(owner: user, target: arbitrary_object) }
  		let(:other_favourite) { FavouriteObject::Favourite.create(owner: user, target_id: 99, target_type: "Sale") }

  		before :each do
  			favourite.save
  			other_favourite.save
  		end

  		it "displays favourites as json" do
  			get :index, format: :json
  			response.body.should have_json_path "favourites/0/id"
  		end

  		it "displays favourites filtered by type" do
  			get :index, format: :json, type: "Sale"
  			response.body.should have_json_path "favourites/0/id"
  			expect(json(response.body)["favourites"].length).to eq 1
  		end

  		it "displays favourites web template" do
  			get :index
  		end
	end

	describe "favouriting an object" do
		it "creates favourite object and toggles is_favourited to true" do
			put :update, target_type: arbitrary_object.class, target_id: arbitrary_object.id

			favourite = FavouriteObject::Favourite.last
			favourite.is_favourited.should eq true
		end

		it "if already exists exists sets is_favourited to false" do
			favourite_object = FavouriteObject::Favourite.create(owner: user, target: arbitrary_object)
			favourite_object.is_favourited = true
			favourite_object.save

			put :update, target_type: arbitrary_object.class.name, target_id: arbitrary_object.id

			favourite = FavouriteObject::Favourite.last
			favourite.is_favourited.should eq false
		end
	end


end
require 'spec_helper'


describe FavouriteObject::FavouritesController do

	let(:user) { User.create({email: "user@example.com" })}
	let(:arbitrary_object) { ArbitraryObject.create() }

	before :each do
	  FavouriteObject::FavouritesController.any_instance.stub(:current_user).and_return(user)
	  FavouriteObject::FavouritesController.any_instance.stub(:authenticate_user!).and_return(true)
	  FavouriteObject::Favourite.any_instance.stub(:message).and_return("Mr. Blobby")

	end

  	describe "listing favourites" do
  		let(:favourite) { FavouriteObject::Favourite.create(owner: user, target: arbitrary_object) }

  		before :each do
  			favourite.is_favourited = true
  			favourite.save
  		end

  		it "displays favourites as json" do
  			get :index, format: :json
  			response.body.should have_json_path "favourites/0/id"
  		end

  		it "displays favourites filtered by type" do
  			get :index, format: :json, type: "ArbitraryObject"
  			response.body.should have_json_path "favourites/0/id"
  			expect(json(response.body)["favourites"].length).to eq 1
  		end

  		it "displays favourites web template" do
  			get :index
  		end
	end

	describe "unfavouriting an object" do
		it "returns null if favourited is equal to false" do
			put :update, target_type: arbitrary_object.class, target_id: arbitrary_object.id
			expect(json(response.body)["favourite"]).to eq nil
		end

		it "if already exists exists and is_favourited is set to false the object gets deleted" do
			favourite_object = FavouriteObject::Favourite.create(owner: user, target: arbitrary_object)
			favourite_object.is_favourited = true
			favourite_object.save

			put :update, target_type: arbitrary_object.class.name, target_id: arbitrary_object.id, favourite: false

			expect(json(response.body)["favourite"]).to eq nil

		end
	end

	describe "favourite a third_party object" do
		it "assigns third_party values" do
			put :update, target_type: "RandomClass", target_id: "object_1", third_party_flag: 'true', favourite: 'true'

			favourite = FavouriteObject::Favourite.last
			favourite.third_party_flag.should eq true
			favourite.third_party_id.should eq "object_1"
			favourite.third_party_type.should eq "RandomClass"
		end
	end
end
require 'spec_helper'

module FavouriteObject
  describe FavouritesController do

    let(:user) { User.create({email: "user@example.com" })}
    let(:arbitrary_object) { ArbitraryObject.create() }
    let(:favourite) { Favourite.create(owner: user, target: arbitrary_object) }

    before :each do
      FavouritesController.any_instance.stub(:current_user).and_return(user)
      FavouritesController.any_instance.stub(:authenticate_user!).and_return(true)
      Favourite.any_instance.stub(:message).and_return("Mr. Blobby")
    end

    describe 'GET show' do
      it "returns 200" do
        get :show, target_type: arbitrary_object.class.name, target_id: arbitrary_object.id, format: :json
        expect(response.response_code).to eq 200
      end

      it "returns favourite status" do
        favourite.update(is_favourited: true)

        get :show, target_type: arbitrary_object.class.name, target_id: arbitrary_object.id, format: :json
        expect(json[:favourite][:is_favourited]).to eq true
      end
    end

    describe "PUT update" do
      it "favouriting object returns is_favourite true" do
        put :update, target_type: arbitrary_object.class.name, target_id: arbitrary_object.id, favourite: {is_favourited: true}, format: :json
        expect(json[:favourite][:is_favourited]).to eq true
      end

      it "unfavouriting object returns is_favourite false" do
        put :update, target_type: arbitrary_object.class.name, target_id: arbitrary_object.id, favourite: {is_favourited: false}, format: :json
        expect(json[:favourite][:is_favourited]).to eq false
      end
    end

    ## Index is used to display a list view of favourites
    describe "GET index" do
      it "returns 200" do
        get :index, format: :json
        expect(response.response_code).to eq 200
      end

      ## doesn't include message data, which adds response_time due to rendering n templates
      it "returns lite payload" do
        favourite.update(is_favourited: true)

        get :index, format: :json, serializer: 'lite'
        expect(json[:favourites][0][:description]).to be_nil
      end

      it "filter by type only" do
        favourite.update(is_favourited: true)
        Favourite.create(owner: user, target_type: 'FakeObject', target_id: 5, is_favourited: true)

        get :index, format: :json, target_type: 'FakeObject'
        expect(json[:favourites].count).to eq 1
      end

      it "returns favourite filtered by type and id" do
        favourite.update(is_favourited: true)
        Favourite.create(owner: user, target_type: 'FakeObject', target_id: 5, is_favourited: true)

        get :index, format: :json, target_type: 'FakeObject', target_ids: [5]
        expect(json[:favourites].count).to eq 1
      end

      it "doesn't return favourite with another id" do
        favourite.update(is_favourited: true)
        Favourite.create(owner: user, target_type: 'FakeObject', target_id: 5, is_favourited: true)

        get :index, format: :json, target_type: 'FakeObject', target_ids: [6]
        expect(json[:favourites].count).to eq 0
      end
    end

  end
end
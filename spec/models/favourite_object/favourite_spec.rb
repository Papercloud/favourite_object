require 'spec_helper'

module FavouriteObject
  describe Favourite do

  	let(:user) { User.create({email: "user@example.com" })}
  	let(:arbitrary_object) { ArbitraryObject.create() }
  	let(:favourite) { FavouriteObject::Favourite.create(owner: user, target: arbitrary_object) }

  	describe "" do
  		before :each do
  			favourite.save
  		end

  		it "toggles the status of a favourite" do
        favourite.is_favourited = false
        favourite.save
        
  			favourite.toggle
  			favourite.is_favourited.should eq true
  		end

      it "returns true for a favourited object" do
        favourite.is_favourited = true
        favourite.save
        status = FavouriteObject::Favourite.is_favourited?(user, arbitrary_object.id, arbitrary_object.class.name)
        status.should eq true
      end

      it "returns true for a favourited third_party object" do
        third_party_favourite = FavouriteObject::Favourite.create(owner: user, third_party_type: "Sale", third_party_id: 1, is_favourited: true, third_party_flag: true)
        third_party_favourite.should be_valid

        status = FavouriteObject::Favourite.is_favourited?(user, 1, "Sale", true)
        status.should eq true
      end

      it "returns false for an unfavourited object" do
        favourite.is_favourited = false
        favourite.save
        status = FavouriteObject::Favourite.is_favourited?(user, arbitrary_object.id, arbitrary_object.class.name)
        status.should eq false
      end


  	end

  end
end

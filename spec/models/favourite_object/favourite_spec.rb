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

      it "returns false for an unfavourited object" do
        favourite.is_favourited = false
        favourite.save
        status = FavouriteObject::Favourite.is_favourited?(user, arbitrary_object.id, arbitrary_object.class.name)
        status.should eq false
      end


  	end

  end
end

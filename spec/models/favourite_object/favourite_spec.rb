require 'spec_helper'

module FavouriteObject
  describe Favourite do

  	let(:user) { User.create({email: "user@example.com" })}
  	let(:arbitrary_object) { ArbitraryObject.create() }
  	let(:favourite) { FavouriteObject::Favourite.create(owner: user, target: arbitrary_object) }

  	describe "status modifiers" do
  		before :each do
  			favourite.save
  		end

  		it "toggles the status of a favourite" do
  			favourite.toggle
  			favourite.is_favourited.should eq false
  		end
  	end
  end
end

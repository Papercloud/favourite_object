module FavouriteObject
  class Favourite < ActiveRecord::Base
    self.table_name = "favourite_object_favourites"

    belongs_to :target, polymorphic: true
    belongs_to :owner, polymorphic: true

    if ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :target, :owner
    end

    def self.for_owner(owner)
    	where(owner_id: owner.id)
    	.where(owner_type: owner.class.base_class)
    end

    #toggles the is_favourited status
    def toggle
    	if is_favourited
    		self.is_favourited = false
    	else
    		self.is_favourited = true
    	end
    	self.save
    end

    def favourite
    	self.is_favourited = true
    	self.save
    end

    def un_favourite
    	self.is_favourited = false
    	self.save
    end

  end
end

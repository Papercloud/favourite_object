module FavouriteObject
  class Favourite < ActiveRecord::Base
    self.table_name = "favourite_object_favourites"

    belongs_to :target, polymorphic: true
    belongs_to :owner, polymorphic: true

    # Params for creating the notification message.
    serialize :params, Hash

    mattr_accessor :views
    @@views = {
      message: {
        template_path: Proc.new {|n| "favourite_object/#{n.target_type.underscore}/message" }
      }
    }

    if ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :target, :owner
    end

    def self.for_owner(owner)
    	where(owner_id: owner.id)
    	.where(owner_type: owner.class.base_class)
    end

    def message
      ActionView::Base.new(
             Rails.configuration.paths["app/views"]).render(
             :template => self.class.views[:message][:template_path].call(self), :formats => [:html], 
             :locals => {object: self.target }, :layout => false)
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

    def self.is_favourited?(owner, target_id, target_type, third_party_flag=false)
        if third_party_flag 
            favourite = FavouriteObject::Favourite.where(owner: owner, third_party_id: target_id.to_s,
                            third_party_type: target_type).first
        else
            favourite = FavouriteObject::Favourite.where(owner: owner, target_id: target_id,
                            target_type: target_type).first
        end

        return false if favourite.blank? || favourite.is_favourited == false

        return true
    end    

    def self.with_type(type)
        where('target_type = ?', type)
    end

  end
end

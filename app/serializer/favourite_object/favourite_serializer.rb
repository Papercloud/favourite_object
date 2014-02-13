class FavouriteObject::FavouriteSerializer < ActiveModel::Serializer
  root :favourites

  attributes :id, :target_id, :target_type, :is_favourited, :description, :third_party_flag, :data

  def description
  	if self.object.third_party_flag == true
  		self.object.params[:description]
  	else
  		self.object.message
  	end 
  end

  def data
  	if self.object.third_party_flag == true
  		self.object.params
  	else
  		[]
  	end 
  end

  def target_id
  	if self.object.third_party_flag == true
  		self.object.third_party_id
  	else
  		self.object.target_id
  	end
  end

  def target_type
  	if self.object.third_party_flag == true
  		self.object.third_party_type
  	else
  		self.object.target_type
  	end
  end

end
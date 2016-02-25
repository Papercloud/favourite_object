class FavouriteObject::LiteFavouriteSerializer < ActiveModel::Serializer
  attributes :id, :target_id, :target_type, :is_favourited, :third_party_flag

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
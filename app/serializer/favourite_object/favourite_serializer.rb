class FavouriteObject::FavouriteSerializer < ActiveModel::Serializer
  root :favourites

  attributes :id, :target_id, :target_type, :is_favourited
end
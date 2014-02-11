class CreateFavouriteObjectFavourites < ActiveRecord::Migration
  def change
    create_table :favourite_object_favourites do |t|
      t.integer :target_id
      t.string :target_type
      t.integer :owner_id
      t.string :owner_type
      t.string :is_favourited, default: true

      t.timestamps
    end
  end
end

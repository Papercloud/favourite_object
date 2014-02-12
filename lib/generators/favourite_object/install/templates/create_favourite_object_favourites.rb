class CreateFavouriteObjectFavourites < ActiveRecord::Migration
  def change
    create_table :favourite_object_favourites do |t|
      t.integer :target_id
      t.string :target_type
      t.integer :owner_id
      t.string :owner_type
      t.boolean :is_favourited, default: false
      t.text :params
      t.boolean :third_party_flag
      t.timestamps
    end
  end
end

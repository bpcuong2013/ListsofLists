class CreateFavoriteLists < ActiveRecord::Migration
  def change
    create_table :favorite_lists do |t|
      t.string :name
      t.integer :rankedlist_id
      t.integer :user_id

      t.timestamps
    end
  end
end

class CreateFavoriteItems < ActiveRecord::Migration
  def change
    create_table :favorite_items do |t|
      t.string :name
      t.integer :favoritelist_id
      t.integer :rankeditem_id

      t.timestamps
    end
  end
end

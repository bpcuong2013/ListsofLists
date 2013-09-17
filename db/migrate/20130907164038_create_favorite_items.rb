class CreateFavoriteItems < ActiveRecord::Migration
  def change
    create_table :favorite_items do |t|
      t.string :name
      t.integer :favorite_list_id
      t.integer :ranked_item_id

      t.timestamps
    end
  end
end

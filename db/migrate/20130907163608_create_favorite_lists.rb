class CreateFavoriteLists < ActiveRecord::Migration
  def change
    create_table :favorite_lists do |t|
      t.string :name
      t.integer :ranked_list_id
      t.integer :user_id

      t.timestamps
    end
  end
end

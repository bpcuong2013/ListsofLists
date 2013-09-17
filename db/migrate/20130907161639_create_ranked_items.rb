class CreateRankedItems < ActiveRecord::Migration
  def change
    create_table :ranked_items do |t|
      t.string :name
      t.integer :ranked_list_id

      t.timestamps
    end
  end
end

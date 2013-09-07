class CreateRankedLists < ActiveRecord::Migration
  def change
    create_table :ranked_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end

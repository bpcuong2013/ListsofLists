class FavoriteItem < ActiveRecord::Base
  belongs_to :favorite_list
  belongs_to :ranked_item
  attr_accessible :id, :favorite_list_id, :name, :ranked_item_id
end

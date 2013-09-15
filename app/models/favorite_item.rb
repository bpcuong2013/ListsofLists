class FavoriteItem < ActiveRecord::Base
  belongs_to :favoritelist
  belongs_to :rankeditem
  attr_accessible :id, :favoritelist_id, :name, :rankeditem_id
end

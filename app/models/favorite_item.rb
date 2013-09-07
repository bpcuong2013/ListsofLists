class FavoriteItem < ActiveRecord::Base
  belongs_to :favoritelist, :rankeditem
  attr_accessible :id, :favoritelist_id, :name, :rankeditem_id
end

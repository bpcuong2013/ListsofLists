class FavoriteItem < ActiveRecord::Base
  belongs_to :favoritelist, :rankeditem
  attr_accessible :favoritelist_id, :name, :rankeditem_id
end

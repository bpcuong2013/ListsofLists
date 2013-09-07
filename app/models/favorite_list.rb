class FavoriteList < ActiveRecord::Base
  belongs_to :rankedlist
  has_many :favoriteitems, :dependent => :destroy
  attr_accessible :name, :rankedlist_id
end

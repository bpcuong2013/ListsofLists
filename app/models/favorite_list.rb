class FavoriteList < ActiveRecord::Base
  belongs_to :rankedlist
  belongs_to :user
  has_many :favoriteitems, :dependent => :destroy
  attr_accessible :id, :name, :rankedlist_id, :user_id
end

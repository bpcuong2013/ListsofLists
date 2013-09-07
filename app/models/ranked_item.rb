class RankedItem < ActiveRecord::Base
  belongs_to :rankedlist
  has_many :favoriteitems, :dependent => :destroy
  attr_accessible :id, :name, :rankedlist_id
end

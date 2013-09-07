class RankedItem < ActiveRecord::Base
  belongs_to :rankedlist
  attr_accessible :name, :rankedlist_id
end

class RankedList < ActiveRecord::Base
  has_many :ranked_items, :dependent => :destroy
  has_many :favorite_lists, :dependent => :destroy
  attr_accessible :id, :name
end

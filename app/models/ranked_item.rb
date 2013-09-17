class RankedItem < ActiveRecord::Base
  belongs_to :ranked_list
  has_many :favorite_items, :dependent => :destroy
  attr_accessible :id, :name, :ranked_list_id
end

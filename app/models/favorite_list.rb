class FavoriteList < ActiveRecord::Base
  belongs_to :ranked_list
  belongs_to :user
  has_many :favorite_items, :dependent => :destroy
  attr_accessible :id, :name, :ranked_list_id, :user_id
end

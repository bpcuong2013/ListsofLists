class RankedList < ActiveRecord::Base
  has_many :rankeditems, :dependent => :destroy
  has_many :favoritelists, :dependent => :destroy
  attr_accessible :name
end

class RankedList < ActiveRecord::Base
  has_many :rankeditems, :dependent => :destroy
  attr_accessible :name
end

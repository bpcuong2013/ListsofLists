class User < ActiveRecord::Base
  has_many :services, :dependent => :destroy
  has_many :favorite_lists, :dependent => :destroy
  
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#,
         #:confirmable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :fullname
end

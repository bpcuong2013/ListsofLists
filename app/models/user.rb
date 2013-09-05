class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :fullname
end

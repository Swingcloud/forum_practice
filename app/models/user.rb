class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :replies

  has_many :user_postships
  has_many :fav_posts, :through => :user_postships, :source => :post

  def short_name
  	self.email.split("@").first
  end
end

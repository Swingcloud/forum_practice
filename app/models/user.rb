class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts , :dependent => :destroy
  has_many :replies, :dependent => :destroy

  has_many :user_postships, :dependent => :destroy
  has_many :fav_posts, :through => :user_postships, :source => :post

  include Gravtastic
  gravtastic

  def short_name
  	self.email.split("@").first
  end

   def admin?
    self.role == "admin"
   end
end

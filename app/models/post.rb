class Post < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	has_many :replies

	has_many :post_groupships
	has_many :groups, :through => :post_groupships
	has_many :user_postships
	has_many :users, :through => :user_postships
	
end

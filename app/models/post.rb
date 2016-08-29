class Post < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	has_many :replies

	has_many :post_groupships
	has_many :groups, :through => :post_groupships
	

end

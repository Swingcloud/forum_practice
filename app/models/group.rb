class Group < ApplicationRecord
	validates_presence_of :name
	has_many :post_groupships, :dependent => :destroy
	has_many :posts, :through => :post_groupships
end

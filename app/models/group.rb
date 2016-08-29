class Group < ApplicationRecord
	has_many :post_groupships
	has_many :posts, :through => :post_groupships
end

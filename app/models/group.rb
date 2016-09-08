class Group < ApplicationRecord
	has_many :post_groupships, :dependent => :destroy
	has_many :posts, :through => :post_groupships
end

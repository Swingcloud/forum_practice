class Post < ApplicationRecord
	validates_presence_of :title
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	belongs_to :user
	has_many :replies , :dependent => :destroy
	has_many :post_likeships
	has_many :users_liked, :through => :post_likeships, :source => :user

	has_many :post_groupships , :dependent => :destroy
	has_many :groups, :through => :post_groupships
	has_many :user_postships , :dependent => :destroy
	has_many :users, :through => :user_postships
	has_many :taggings
	has_many :tags, :through => :taggings

	def tag_list
		self.tags.map{ |t| t.name }.join(",")
	end

	def tag_list=(str)
		ids = str.split(',').map do |tag_name|
			tag_name = tag_name.strip.downcase
			tag = Tag.find_by_name(tag_name) || Tag.create(:name => tag_name)
			tag.id
		end

		self.tag_ids = ids
	end





		
	def reply_user
		c_user =[]
      self.replies.each do |r|
        c_user << r.user.nickname
     	end
    c_user = c_user.uniq
	end

	# #Post.order
	# def self.order 
	# 	puts "class"
	# end

	# #@post.order
	# def order
	# 	puts "instance"
	# end

end

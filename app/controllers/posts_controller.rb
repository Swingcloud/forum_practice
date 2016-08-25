class PostsController < ApplicationController

	def index
		@posts = Post.all
		@post = Post.new
	end

	def create 
		@post = Post.new(params_permitted)
		@post.save
			flash[:notice]= "新增成功"
			redirect_to posts_path
		# redirect_to post_path(@post)
	end

	def show
		@post = Post.find(@post)
	end

	private

	def params_permitted 
		params.require(:post).permit(:title, :content)
	end
end

class PostRepliesController < ApplicationController
	before_action :find_post

	def new
		@reply = Reply.new 
	end

	def create 
		@reply = @post.replies.build(params_permitted)
		@reply.user = current_user
		if @reply.save
			flash[:notice]= "新增成功"
			@post.last_replies = @reply.created_at
			@post.save

			respond_to do |format|
				format.html {redirect_to post_path(@post)}
				format.js
			end

		else
			render "posts/show"
		end
	end

	def destroy
		@reply = @post.replies.find(params[:id]).destroy
		

		respond_to do |format|
			format.html {redirect_to post_path(@post)}
			format.js
		end
	end





	private

	def find_post
		@post = Post.find(params[:post_id])
	end

	def params_permitted
		params.require(:reply).permit(:comment)
	end

end

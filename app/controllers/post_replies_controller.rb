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
			redirect_to post_path(@post)
		else
			render :action => :new
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

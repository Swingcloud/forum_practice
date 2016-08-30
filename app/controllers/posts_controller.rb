class PostsController < ApplicationController
	before_action :set_post, :only => [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, :except => [:index]

	#GET posts/index
	#GET /posts
	def index
		if params[:id]
			@post = Post.find(params[:id])
		else
			@post = Post.new
		end
		if params[:order]
			sort_by = (params[:order] == 'replies_count') ? 'replies_count DESC' : 'last_replies DESC'
  		@posts = Post.order(sort_by).page(params[:page]).per(5)
  	else
  		@posts = Post.page(params[:page]).per(10)
		end
		

			
	end
	#GET posts/new
	def new 
		@post = Post.new
	end


  #POST /posts
	def create 
		@post = Post.new(params_permitted)
		@post.user = current_user
		if @post.save
			flash[:notice]= "新增成功"
			redirect_to post_path(@post)
		else
			@posts = Post.all
			render :action => :index
	end
	end

	#GET /posts/:id
	def show
		@replies = @post.replies
	end

	def edit
		
	end

	def update
		
		if @post.update(params_permitted)
			flash[:notice]="編輯成功"
			redirect_to post_path(@post)
		else
			render :action => :edit
		end
	end

	def destroy
		@post.destroy
		flash[:alert] = "刪除成功"
		redirect_to posts_path
	end

	def about
		@users=User.all
		@posts=Post.all
		@replies= Reply.all

	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def params_permitted 
		params.require(:post).permit(:title, :content,:group_ids => [])
	end
end

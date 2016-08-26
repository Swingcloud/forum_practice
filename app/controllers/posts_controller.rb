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
			@posts = Post.all
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

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def params_permitted 
		params.require(:post).permit(:title, :content)
	end
end

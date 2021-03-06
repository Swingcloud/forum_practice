class PostsController < ApplicationController
	before_action :set_post, :only => [:show, :edit, :update, :destroy, :favorite, :like]
	before_action :authenticate_user!, :except => [:index]

	#GET posts/index
	#GET /posts
	def index
		if params[:id]
			@post = Post.find(params[:id])
		else
			@post = Post.new
		end
		
		prepare_variable_for_index_template
		
		@groups=Group.all
		
		if params[:groupid]
			# @posts = Group.find(params[:groupid]).posts.order('id ASC').page(params[:page]).per(10)
			@posts = @posts.includes(:groups).where('groups.id' => params[:groupid] )
		end

		@posts = @posts.page(params[:page]).per(10)
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
			is_draft?
			flash[:notice]= "新增成功"
			redirect_to post_path(@post)	
		else
			render :action => :new
		end
	end

	#GET /posts/:id
	def show
		@replies = @post.replies
		@post.page_views +=  1 
		@post.save

		@reply = Reply.new
	end

	def edit
		
	end

	def update
		if params[:remove_upload_file] == "1"
      @post.image = nil
    end
		
		if @post.update(params_permitted)
			is_draft?
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

	def favorite
		if current_user.faved_post?(@post)
			current_user.fav_posts.delete(@post)
		else
			current_user.fav_posts << @post
		end
    
    respond_to do |format|
    	format.html { redirect_to post_path(@post) }
    	format.js
    end
	end

	def like
		if current_user.liked_post?(@post)
			current_user.liked_post.delete(@post)
		else
			current_user.liked_post << @post
		end

		respond_to do |format|
			format.html { redirect_to post_path(@post)}
			format.js
		end
	end














	private

	def post_sort(sort_by)
	 	@posts = @posts.order(sort_by).page(params[:page]).per(10)
	end


	def set_post
		@post = Post.find(params[:id])
	end

	def params_permitted 
		params.require(:post).permit(:title, :content,:page_views,:image, {:tag_list =>[]}  ,{:group_ids => []})
	end


	def prepare_variable_for_index_template
			@posts= Post.includes(:users_liked,:replies)
		if current_user.try(:admin?)
			@posts = @posts.all
		elsif current_user
			@posts = @posts.where('user_id=? OR is_public=?', current_user.id, true)
		else
			@posts = @posts.where(:is_public => true)
		end

		case params[:order]
		when 'replies_count'
		 	sort_by = 'replies_count DESC'
		 	post_sort(sort_by)
		when 'last_replies'
		 	sort_by = 'last_replies DESC'
		 	post_sort(sort_by)
		when 'page_views'
		 	sort_by = 'page_views DESC'
		 	post_sort(sort_by)
		end	

		if params[:tag]
			tag =Tag.find_by_name(params[:tag])
			@posts = tag.posts
		end
	end

	def is_draft?
		if params[:commit] == "正式發送"
			@post.is_public = true
			@post.save
		elsif params[:commit] =="儲存草稿"
			@post.is_public =false
			@post.save
		else 
			@post.is_public = false
			@post.save
		end
	end



end
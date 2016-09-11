class Admin::GroupsController < ApplicationController
	before_action :find_group, :only => [:edit, :destroy, :update]

	def new
		@group = Group.new
	end


	def create 
		@group = Group.new(params_permitted)
		if @group.save
			flash[:notice]= "新增成功"
			redirect_to admin_posts_path	
		else
			flash[:alert]= "群組名稱不能空白！"
			redirect_back :fallback_location=> :index
		end
	end

	def destroy
		
		if @group.posts.count == 0
			@group.destroy
			flash[:alert] = "刪除成功"
			redirect_to admin_posts_path
		else
			flash[:alert] = "群組裡有文章，不能刪除！！！"
			redirect_to admin_posts_path
		end
	end


	def update
		if @group.update(params_permitted)
			flash[:notice]="編輯成功"
			redirect_to admin_posts_path
		else
			flash[:alert]= "群組名稱不能空白！"
			redirect_back :fallback_location=> :index
		end
	end

	private

	def params_permitted
		params.require(:group).permit(:name) 
	end

	def find_group 
		@group =Group.find(params[:id])
	end
end

class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		
		if @user.update(profile_permit)
			flash[:notice]="更新成功"
			redirect_to user_path(@user)
		else
			render :action => :edit
		end
	end

	private

	def profile_permit
		params.require(:user).permit(:about_me)
	end

end

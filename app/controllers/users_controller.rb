class UsersController < ApplicationController
	before_action :authenticate_user!


	def index 
		@users = User.all
	end

	def show
		
		@user = User.includes(:liked_post).find_by_nickname(params[:id])
	end

	def edit
		@user = User.find_by_nickname(params[:id])
	end

	def update
		@user = User.find(params[:id])
		
		if @user.update(profile_permit)
			flash[:notice]="更新成功"
			redirect_to user_path(@user.nickname)
		else
			render :action => :edit
		end
	end

	def switch
    user = User.find( params[:id] )
    reset_session
    session[:user_id] = user.id

    render :text => "this is bad"
  end




	private

	def profile_permit
		params.require(:user).permit(:about_me)
	end

end

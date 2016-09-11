class Admin::PostsController < ApplicationController
	before_action :authenticate_user!

	before_action :check_admin 
	layout "admin"


	def index
    @users = User.all	
    @groups=Group.all
    

    if params[:id]
      @group=Group.find(params[:id])
    else
      @group=Group.new
    end

	end
  

  def bulk_update
    ids = Array( params[:ids] )
    users = ids.map{ |i| User.find_by_id(i)}.compact
    #compact把nil去除
    if  params[:commit] == "升為管理人員"
      users.each {|u| u.update(:role => "admin")}
    elsif params[:commit] == "刪除人員"
      users.each { |u| u.destroy}
    end 
    redirect_to  admin_posts_path
  end


	protected

  def check_admin
  	unless current_user.admin?
  		raise ActiceRecoed::RecordNotFound
  		return
  	end
    # authenticate_or_request_with_http_basic do |user_name, password| 很陽春的驗證流程
    #        user_name == "username" && password == "password"
    # end
  end

  def event_params
    params.require(:user).permit(:role) 
  end

end

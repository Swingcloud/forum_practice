class Admin::PostsController < ApplicationController
	before_action :authenticate_user!

	before_action :check_admin 
	layout "admin"


	def index
		@posts = Post.all
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
end

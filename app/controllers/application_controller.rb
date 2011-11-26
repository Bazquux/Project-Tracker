class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
    	flash[:alert] = "You must be an admin to perform this action"
    	redirect_to root_path
    end
  end  
end

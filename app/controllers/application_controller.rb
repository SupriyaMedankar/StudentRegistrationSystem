class ApplicationController < ActionController::Base
  before_action :authorized
  helper_method :current_user, :logged_in?, :admin_user?
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?   
    !current_user.nil?
  end

  def admin_user?
    current_user.admin?
  end

  def authorized
    redirect_to '/welcome' unless logged_in?
  end
end

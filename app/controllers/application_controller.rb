class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :verify_permissions

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def verify_permissions
    render file: '/public/unauthorized_access' unless current_user
  end
end

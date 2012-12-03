class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def me
  	@me ||= @current_user.facebook.get_object("me")
  end
  helper_method :me

end

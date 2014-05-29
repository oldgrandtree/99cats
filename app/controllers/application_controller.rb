class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include SessionsHelper
  protect_from_forgery with: :exception

  def require_signed_out
    redirect_to root_url unless current_user.nil?
  end

  def require_signed_in
    redirect_to new_session_url if current_user.nil?
  end
end

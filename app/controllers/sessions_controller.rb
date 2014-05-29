class SessionsController < ApplicationController
  before_action :require_signed_out, only: [:create, :new]

  def new
  end

  def create
    @user = User.find_by_credentials(*session_params.values)

    if @user
      login_user!
      redirect_to root_url
    else
      flash[:errors] = "Wrong username or password"
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end

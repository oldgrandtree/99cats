class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_credentials(*session_params.values)

    if @user
      @user.reset_session_token!
      flash[:notices] = "Welcome #{@user.user_name}!"
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      flash[:errors] = "Wrong username or password"
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end

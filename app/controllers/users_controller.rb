class UsersController < ApplicationController
  before_action :require_signed_out, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to root_url
    else
      render :new
    end
  end

  def sessions
    if User.find(params[:id]) == current_user
      @sessions = current_user.sessions
    else
      flash[:notices] = "Can't view other users session!"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

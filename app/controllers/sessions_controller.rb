class SessionsController < ApplicationController
  def new
    store_location
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user
      log_in @user
      redirect_back_or @user
    else
      flash.now[:danger] = 'Invalid username'
      render 'new'
    end
  end
end
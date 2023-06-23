class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login, :create, :welcome]

  def create
    @user = User.find_by(email: params[:email])

    if !!@user && @user.active && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      message = @user&.active ? "Invalid credentials" : "Admin
      will verify your details soon"
      redirect_to login_path, notice: message
    end
  end

  def login
  end

  def welcome
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

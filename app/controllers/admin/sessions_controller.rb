class Admin::SessionsController < ApplicationController
  def new
    if @current_user
      redirect_to admin_articles_path
    end
    @user = User.new
  end

  def create
    user_params = params[:user]
    @user = User.find_by_email(user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      self.current_user = @user
      if params[:redirect_to]
        redirect_to params[:redirect_to]
      else
        redirect_to admin_path
      end
    else
      flash[:error] = "Invalid email or password provided..."
      redirect_to new_admin_session_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_admin_session_path
  end
end

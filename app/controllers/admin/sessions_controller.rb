class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if (@user.authenticate(params[:password]))
      session[:user_id] = @user.id
    end
  end

  def destroy
  end
end

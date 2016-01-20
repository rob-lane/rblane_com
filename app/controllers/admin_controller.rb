class AdminController < ApplicationController
  before_filter :authenticate_user

  private

  def authenticate_user
    if @current_user.nil?
      redirect_to admin_sessions_new_path
    end
  end
end
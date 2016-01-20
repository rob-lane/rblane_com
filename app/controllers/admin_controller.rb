class AdminController < ApplicationController
  before_filter :authenticate_user

  private

  def authenticate_user
    if @current_user.nil?
      redirect_to new_admin_session_path
    end
  end
end
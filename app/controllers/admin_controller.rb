class AdminController < ApplicationController
  before_filter :authenticate_user

  protected

  def authenticate_user
    redirect_to new_admin_session_path unless signed_in?
  end
end
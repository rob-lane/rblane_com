class AdminController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user

  def index
    @category = params.fetch(:category) { 'index' }
  end

  protected

  def authenticate_user
    redirect_to new_admin_session_path unless signed_in?
  end
end
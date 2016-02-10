class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :add_template_path
  before_action :load_title

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def signed_in?
    !!current_user
  end

  def template_name
    @template_name ||= Setting.find_by(:name => 'template_name').value
  end

  def add_template_path
    template_path = Rails.root.join('app', 'templates', 'current')
    prepend_view_path(template_path.join('views')) unless view_paths.include?(template_path.join('views'))
  end

  def load_title
    @title ||= Setting.find_by(:name => 'title').try(:value)
  end

end

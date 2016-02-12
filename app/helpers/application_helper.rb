module ApplicationHelper

  def current_template
    Rails.application.config.templates.template_name
  end

end

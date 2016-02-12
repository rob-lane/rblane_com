module ApplicationHelper

  def current_template
    Rails.application.config.templates.template_name
  end

  def title
    Setting.find_by(:name => 'title').try(:value)
  end

  def subtitle
    Setting.find_by(:name => 'subtitle').try(:value)
  end

end

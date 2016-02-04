module ApplicationHelper

  def current_template
    Setting.find_by(:name => 'template_name').value
  end

end

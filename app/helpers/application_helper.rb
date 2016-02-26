module ApplicationHelper

  def title
    Setting.find_by(:name => 'title').try(:value)
  end

  def subtitle
    Setting.find_by(:name => 'subtitle').try(:value)
  end

end

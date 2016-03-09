module ApplicationHelper

  def title
    Setting.find_by(:name => 'title').try(:value)
  end

  def subtitle
    Setting.find_by(:name => 'subtitle').try(:value)
  end

  def remote_image_tag(name, options = {})
    image = Image.find_by(name: name)
    if image.nil?
      Rails.logger.error("Invalid image name #{name} for remote_image_tag")
      image_tag('default.png', options)
    else
      image_tag(image.url, options)
    end
  end

end

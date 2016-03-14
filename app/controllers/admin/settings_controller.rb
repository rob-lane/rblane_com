class Admin::SettingsController < AdminController

  def index
    @settings = Setting.all
  end

  def update
    params[:settings].each do |setting_params|
      setting = Setting.find_by(:id => setting_params[:id])
      if setting.field_type == 'image' && setting_params[:value].present?
        update_image_setting(setting, setting_params[:value])
      else
        setting.value = setting_params[:value]
      end
      setting.save!
    end
    redirect_to admin_settings_path
  end

  def revert
    setting = Setting.find(params[:id])
    if setting.field_type == 'image'
      image = Image.find_by(:name => setting.name)
      image.file.clear
      image.save
    end
    render nothing: true
  end

  private

    def update_image_setting(setting, file)
      image = Image.find_by(:name => setting.name)
      image ||= Image.new(:name => setting.name)
      image.user = current_user
      image.file = file
      image.save!
    end

end

class Admin::SettingsController < AdminController

  def index
    @settings = Setting.all
  end

  def update
    params[:settings].each do |setting_params|
      setting = Setting.find_by(:id => setting_params[:id])
      setting.value = setting_params[:value]
      setting.save!
    end
    redirect_to admin_settings_path
  end

end

class Admin::SettingsController < AdminController

  def index
    @settings = Setting.all
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update(settings_params)
    redirect_to admin_settings_path
  end

  protected

    def settings_params
      params.require(:setting).permit(:value)
    end

end

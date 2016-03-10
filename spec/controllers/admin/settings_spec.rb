require 'rails_helper'

RSpec.describe Admin::SettingsController, :type => :controller do
  include_examples "an admin controller"

  context 'GET #index' do
    before do
      @settings = Setting.create([
       {name: 'test-one', value: 'value-one'},
       {name: 'test-two', value: 'value-two'}])
    end

    after do
      Setting.all.delete_all
    end

    it 'responds with success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index view' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all settings' do
      get :index
      expect(assigns(:settings).to_a).to eq(Setting.all.to_a)
    end
  end

  context 'PUT #update' do
    before do
      @setting = Setting.create(name: 'test-setting', value: 'test-value')
    end

    after do
      @setting.destroy!
    end

    let(:params) do
      {:settings => [:id => @setting.id, :name => @setting.name, :value => @setting.value]}
    end

    it 'redirects to index' do
      put :update, params
      expect(response).to redirect_to(admin_settings_path)
    end

    it 'updates the provided settings' do
      new_value = 'updated value'
      params[:settings].first[:value] = new_value

      put :update, params
      expect(@setting.reload.value).to eq(new_value)
    end

    context 'including an image setting' do

      before do
        @image_setting = Setting.create(:name => 'test-image', :field_type => 'image')
        params[:settings] << {:id => @image_setting.id, :name => @image_setting.name,
                              :value => fixture_file_upload("#{Rails.root.join('spec', 'fixtures', 'default.jpg')}", 'image/png')}
      end

      after do
        Image.find_by(:name => @image_setting.name).try(:delete)
        @image_setting.destroy!
      end

      it 'creates a new image model' do
        put :update, params
        image = Image.find_by(:name => @image_setting.name)
        expect(image).to_not be_nil
        expect(image).to be_valid
      end

    end


  end
end
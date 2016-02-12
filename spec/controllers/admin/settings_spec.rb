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
  end
end
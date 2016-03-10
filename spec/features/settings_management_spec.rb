require 'rails_helper'

RSpec.describe 'Settings management', :type => :feature do
  include_examples "signed in"

  context 'viewing all settings' do
    it 'displays a form containing all settings' do
      visit '/admin/settings'
      within('form') do
        Setting.all.each do |setting|
          expect(page).to have_content(setting.name.humanize)
          expect(page).to have_selector("input[value='#{setting.value}']")
        end
      end
    end
  end

  context 'the title setting' do
    before do
      @setting = FactoryGirl.create(:title_setting)
    end

    after do
      @setting.destroy!
    end

    it 'displays on the default home page' do
      visit '/'
      expect(page.first('h1.title').text).to eq(@setting.value)
    end

    it 'displays as the default page title' do
      visit '/'
      expect(page).to have_title(@setting.value)
    end

    context 'updated from admin' do

      before do
        @original_title = @setting.value
        @title = 'Updated title'
      end

      after do
        @setting.update(:value => @original_title)
      end

      it 'is updated on the default home page' do
        visit '/admin/settings'
        fill_in "setting_#{@setting.id}", :with => @title
        click_button 'Save'
        visit '/'
        expect(page.first('h1.title').text).to eq(@title)
      end

      it 'is updated as the default title' do
        visit '/admin/settings'
        fill_in "setting_#{@setting.id}", :with => @title
        click_button 'Save'
        expect(page).to have_title(@title)
      end

    end

  end

  context 'the logo setting' do
    before do
      @setting = FactoryGirl.create(:logo_setting)
      @image = Image.create!(name: @setting.name, user: @user)
    end

    after do
      @setting.destroy!
      @image.destroy!
    end

    it 'displays on the default home page' do
      visit '/'
      within("#page-header") do
        expect(page.first('img')['src']).to include(@image.file.url)
      end
    end

    context 'updated from admin' do
      before do
        @original_value = @image.file.url
        @new_image_file = Rails.root.join('spec', 'fixtures', 'default.jpg')
      end

      it 'is updated on the default home page' do
        visit '/admin/settings'
        attach_file "setting_#{@setting.id}", @new_image_file
        click_button 'Save'
        visit '/'
        within("#page-header") do
          expect(page.first('img')['src']).to include(@image.file.url)
        end
      end
    end
  end

end
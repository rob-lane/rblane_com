RSpec.shared_examples "signed in" do

  before(:all) do
    @user = FactoryGirl.create(:admin)
  end

  before do
    visit '/admin/sessions/new'
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Log In'
  end

  after do
    visit '/admin/articles'
    click_link "Logout"
  end

  after(:all) do
    @user.destroy!
  end

end
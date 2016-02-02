module SignInHelper

  def sign_in
    visit '/admin/sessions/new'
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Log In'
  end

  def sign_out
    visit '/admin/articles'
    click_link "Logout"
  end

end
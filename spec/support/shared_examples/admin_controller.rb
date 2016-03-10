RSpec.shared_examples "an admin controller" do

  let!(:admin_user) do
    user = User.find_by_email('test@testuser.test')
    user ||= User.create(:email => 'test@testuser.test', :password => 'password')
  end

  before do
    subject.send(:current_user=, admin_user)
  end

  after do
    if admin_user.persisted?
      admin_user.articles.delete_all
      admin_user.destroy!
    end
  end
end
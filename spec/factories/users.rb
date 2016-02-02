FactoryGirl.define do
  factory :admin, :class => :user do
    email "testuser@testing.test"
    password "password"
  end
end

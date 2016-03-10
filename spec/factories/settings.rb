FactoryGirl.define do
  factory :title_setting, :class => :setting do
    name "title"
    value "Test Title"
  end

  factory :logo_setting, :class => :setting do
    name "logo"
    value ""
    field_type "image"
  end

end
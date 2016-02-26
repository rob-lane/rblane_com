require 'rails_helper'

describe Image do
  it_behaves_like "it is remotely storable"

  subject do
    Image.new(
        :content => test_content,
        :name => 'Test Image',
        :format => 'image/jpg',
        :user => user)
  end

  let(:user) do
    FactoryGirl.create(:admin)
  end

  before do
    subject.s3_key = subject.default_s3_key
  end

  after do
    user.destroy!
  end

  let(:test_content) do
    'http://image-url/test_image.jpg'
  end

  it 'is invalid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is valid with content and a user' do
    expect(subject.content).to_not be_empty
    expect(subject.user).to_not be_nil
    expect(subject).to be_valid
  end

end
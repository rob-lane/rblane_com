require 'rails_helper'

describe Image do
  subject do
    Image.new(
        :file => test_file,
        :name => 'Test Image',
        :user => user)
  end

  let(:test_file) do
    fixture_file('default.jpg')
  end

  let!(:user) do
    FactoryGirl.create(:admin)
  end

  after do
    user.destroy!
  end

  it 'has a file attachment' do
    expect(subject).to have_attached_file(:file)
  end

  it 'validates attachment as an image' do
    invalid_types, valid_types = ['text/plain', 'text/html'], ['image/png', 'image/jpg', 'image/gif']
    expect(subject).to validate_attachment_content_type(:file).allowing(*valid_types).rejecting(*invalid_types)
  end

  context 'created without a user' do

    it 'is invalid' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

  end

  context 'created without a name' do

    it 'is invalid' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

  end

  it 'is valid with content, file attachment and a user' do
    expect(subject).to be_valid
  end

end
require 'rails_helper'

describe Article do
  subject do
    Article.new(
        :file => test_file,
        :title => 'test article')
  end

  after do
    subject.destroy! if subject.persisted?
  end

  let(:test_file) { fixture_file('sample-article.html') }

  it 'has a file attachment' do
    expect(subject).to have_attached_file(:file)
  end

  it 'validates attachment as html' do
    invalid_types, valid_types = ['image/png', 'image/jpg', 'image/gif'], ['text/plain']
    expect(subject).to validate_attachment_content_type(:file).allowing(*valid_types).rejecting(*invalid_types)
  end

  it 'validates attachment presence' do
    expect(subject).to validate_attachment_presence(:file)
  end

  context 'created without a title' do

    it 'is invalid' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

  end

  context 'created without a file' do

    it 'is invalid' do
      subject.file = nil
      expect(subject).to_not be_valid
    end

  end

  context 'content' do

    it 'returns attachment content' do
      expect(subject.content).to eql(test_file.read)
    end

  end

end
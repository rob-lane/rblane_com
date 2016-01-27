require 'rails_helper'

describe Article do
  it_behaves_like "it is remotely storable"

  subject { Article.new( :content => test_content, :title => 'test article', :s3_key => 'test_key.html') }
  let(:test_content) { 'Test Content' }

  it 'is invalid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is valid with content' do
    expect(subject.content).to_not be_empty
    expect(subject).to be_valid
  end

  context 'being saved' do

    it 'syncs to the remote client' do
      expect(subject.s3).to receive(:put_object)
      subject.save!
      expect(subject).to be_valid
      subject.destroy!
    end

  end

  context 'being destroyed' do

    before { subject.save }

    it 'destroys content with remote client' do
      expect(subject.s3).to receive(:delete_object)
      subject.destroy
    end

  end

end
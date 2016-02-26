RSpec.shared_examples "it is remotely storable" do

  before do
    @mock_client = double("S3")
    @mock_response = double("Response")
    @store_options = described_class.store_options
    allow(subject).to receive(:s3) { @mock_client }
    allow(@mock_client).to receive(:put_object)
    allow(@mock_client).to receive(:get_object) { @mock_response }
    allow(@mock_client).to receive(:delete_object)
    allow(@mock_response).to receive(:body) { StringIO.new(test_content) }
    allow(@mock_response).to receive(:public_url) { test_content }
  end

  it 'with valid store options' do
    expect(described_class).to be_valid_remote_store
  end

  context 'syncing content' do

    it 'using the correct options' do
      put_options = {
          :acl => 'public-read',
          :body => subject.content,
          :content_length => subject.content.length,
          :key => "#{@store_options[:path]}/#{subject.s3_key}",
          :bucket => @store_options[:bucket]
      }
      expect(@mock_client).to receive(:put_object).with(put_options)
      subject.sync
    end

  end

  context 'fetching content' do

    it 'using the correct options' do
      get_options = {
          :bucket => @store_options[:bucket],
          :key => "#{@store_options[:path]}/#{subject.s3_key}"
      }
      expect(@mock_client).to receive(:get_object).with(get_options)
      subject.fetch_content
    end

    it 'storing object from the client' do
      subject.content = ''
      subject.fetch_content
      expect(subject.content).to eql(test_content)
    end

  end

  context 'destroying content' do

    it 'using the correct options' do
      delete_options = {
          :bucket => @store_options[:bucket],
          :key => "#{@store_options[:path]}/#{subject.s3_key}"
      }
      expect(@mock_client).to receive(:delete_object).with(delete_options)
      subject.destroy_content
    end

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
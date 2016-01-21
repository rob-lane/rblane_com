require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @record = Article.new(:title => 'test article', :content => '<html><body>foo</body></html>')
    @mock_client = MiniTest::Mock.new
    @record.instance_variable_set(:@s3, @mock_client)
    def @mock_client.put_object(args); nil; end
  end

  test 'valid store options' do
    assert(@record.class.valid_remote_store?, "Article should define valid RemotelyStorable options")
  end

  test 'sync uses correct options' do
    store_options = @record.class.store_options.dup
    # Defaults set by sync method
    store_options[:acl] ||= 'private'
    # Values populated by sync method
    store_options[:body] ||= @record.content
    store_options[:content_length] ||= @record.content.length
    store_options[:key] ||= "#{store_options[:path]}/#{@record.s3_key}}"
    @mock_client.expect(:put_object, nil, [store_options])
    @record.sync
  end

  test 'invalid without content' do
    @record.content = nil
    assert(@record.invalid?, 'Article without content should be invalid')
  end

  test 'valid with content' do
    assert_not_nil(@record.content, 'Content should be populated on a valid Article')
    assert(@record.valid?, 'Article with content should be valid')
  end

  test 'syncs to client on save' do
    @mock_client.expect(:put_object, nil, [Hash])
    @record.save!
    assert(@record.valid?, 'Synced article should be valid')
    @record.destroy
  end

end

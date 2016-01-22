require 'test_helper'
require 'support/remotely_storable_test'

class ArticleTest < ActiveSupport::TestCase
  include RemoteleyStorableTest

  def setup
    @record = Article.new(:title => 'test_article', :content => 'Test Content', s3_key: 'test_key.html')
    super
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
    # TODO: Improve IOC and dep. injection for this
    @record.instance_variable_set(:@s3, @mock_client)

    @mock_client.expect(:put_object, nil, [Hash])
    @record.save!
    assert(@record.valid?, 'Synced article should be valid')
    @record.destroy
  end

end

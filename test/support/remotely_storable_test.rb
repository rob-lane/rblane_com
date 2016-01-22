module RemoteleyStorableTest

  def setup
    @mock_client = MiniTest::Mock.new
    @record.instance_variable_set(:@s3, @mock_client)
    @store_options = @record.class.store_options
  end

  def test_valid_store_options
    assert(@record.class.valid_remote_store?, "Article should define valid RemotelyStorable options")
  end

  def test_sync_uses_correct_options
    put_options = {
        # Values set by sync method
        :acl    =>  'public-read',
        :body   =>  @record.content,
        :content_length =>  @record.content.length,
        # Values read from options
        :key    =>  "#{@store_options[:path]}/#{@record.s3_key}",
        :bucket =>  @store_options[:bucket]
    }
    @mock_client.expect(:put_object, nil, [put_options])
    @record.sync
  end

  def test_fetch_content_uses_correct_options
    expected_options = {
        :bucket   =>  @store_options[:bucket],
        :key      =>  "#{@store_options[:path]}/#{@record.s3_key}" }
    @mock_client.expect(:get_object, nil, [expected_options])
    @record.fetch_content
  end

  def test_fetch_content_gets_object_from_client
    @record.content = ''
    test_content = 'Test Content'
    @mock_client.expect(:get_object, 'Test Content', [Hash])

    @record.fetch_content
    assert_equal(test_content, @record.content, 'Fetch content should populate content from s3 client')
  end
end
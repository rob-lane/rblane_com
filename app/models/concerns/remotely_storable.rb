module RemotelyStorable
  extend ActiveSupport::Concern

  included do
    validates :s3_key, :presence => true
    validates :content, :presence => true
    validates_presence_of :format
    before_create :sync
    before_destroy :destroy_content
    after_find :fetch_content
    attr_accessor :format
    class << self
      attr_reader :store_options
    end
    @required_options = [:bucket, :path]
    @store_options = {}
  end

  module ClassMethods
    def store_remotely(options)
      @store_options.merge!(options)
      unless valid_remote_store?
        raise ActiveModel::MissingAttributeError, "Missing options to be RemotelyStorable: #{@missing_options.join}"
      end
    end

    def valid_remote_store?
      @missing_options = @required_options.reject{|option| @store_options[option].present?}
      if @missing_options.empty?
        true
      else
        false
      end
    end
  end

  def store_options
    self.class.store_options
  end

  def sync
    if self.valid?
      s3.put_object(:acl => store_options.fetch(:acl) { 'public-read'},
                    :bucket => store_options[:bucket],
                    :key => "#{store_options[:path]}/#{s3_key}",
                    :body => self.content,
                    :content_length => self.content.length)
    end
  end

  def fetch_content
    if self.s3_key.present?
      response = s3.get_object(:bucket => store_options[:bucket], :key => "#{store_options[:path]}/#{s3_key}")
      if self.format =~ /^image/
        self.content = response.public_url
      else
        self.content = response.body.read
      end
    end
  end

  def destroy_content
    if self.s3_key.present?
      s3.delete_object(:bucket => store_options[:bucket], :key => "#{store_options[:path]}/#{s3_key}")
    end
  end

  def s3
    @s3 ||= Aws::S3::Client.new
  end

end
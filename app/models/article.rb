class Article < ActiveRecord::Base
  include RemotelyStorable
  attr_accessor :content

  before_validation :default_format
  before_validation :default_s3_key
  validates_presence_of :title

  store_remotely :bucket => 'coolane', :path => 'rblane_com/articles'
  belongs_to :author, :class_name => :user

  private

  def default_format
    self.format ||= 'html'
  end

  def default_s3_key
    self.s3_key ||= "#{SecureRandom.uuid}.#{self.format}"
  end
end

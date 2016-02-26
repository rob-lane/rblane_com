class Image < ActiveRecord::Base
  include RemotelyStorable
  attr_accessor :content

  before_validation :default_format
  before_validation :default_s3_key
  validates_presence_of :name
  validates_presence_of :user

  store_remotely :bucket => 'coolane', :path => 'rblane_com/images'
  belongs_to :user

  def default_format
    self.format ||= 'image/png'
  end

  def default_s3_key
    self.s3_key ||= "#{self.name}-#{SecureRandom.uuid}.#{self.format.split('/').last}"
  end

end
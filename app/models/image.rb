class Image < ActiveRecord::Base
  has_attached_file :file, :content_type => ['image/png', 'image/jpg', 'image/gif'],
                    :path => '/rblane_com/images/:style/:filename', :default => '/assets/default.png'
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :file
  validates_presence_of :name
  validates_presence_of :user
  belongs_to :user
end
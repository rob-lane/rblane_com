class Article < ActiveRecord::Base
  attr_accessor :file
  has_attached_file :file, :content_type => "text/plain", :path => '/rblane_com/articles/:filename'
  validates_attachment :file, :presence => true, :content_type => { :content_type => "text/plain" }
  validates_presence_of :title
  belongs_to :author, :class_name => :user

  def content
    Paperclip.io_adapters.for(file).read.gsub(/\r\n?/, "\n")
  end

  def content=(content)
    self.update!(file: content)
  end
end

class Article < ActiveRecord::Base
  attr_accessor :file
  attr_writer :content
  has_attached_file :file, :path => '/rblane_com/articles/:filename'
  validates_attachment :file, :presence => true, :content_type => { :content_type => ['text/plain', 'message/news'] }
  validates_presence_of :title
  validates_presence_of :content
  before_validation :put_content
  belongs_to :author, :class_name => :user

  def content
    Paperclip.io_adapters.for(file).read.to_s.gsub(/\r\n?/, "\n")
  end

  def put_content
    return if @content.to_s.blank?
    self.file = StringIO.new(@content)
    self.file_file_name = "#{title.parameterize}.txt"
    self.file.save
  end

end

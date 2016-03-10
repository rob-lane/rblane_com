class Setting < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates_presence_of :field_type
  before_validation :default_field_type

  def default_field_type
    self.field_type ||= 'text'
  end
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
Dir["./spec/support/**/*.rb"].sort.each {|f| require f}
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require "paperclip/matchers"

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FixturesHelper
  config.include Paperclip::Shoulda::Matchers

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  Capybara.javascript_driver = :webkit
end
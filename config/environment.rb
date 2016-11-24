# Load the Rails application.
require_relative 'application'
require 'carrierwave/orm/activerecord'
# Initialize the Rails application.
Rails.application.initialize!
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

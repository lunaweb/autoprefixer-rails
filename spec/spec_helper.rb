ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../app/config/environment', __FILE__)
require File.expand_path('../../lib/autoprefixer-rails', __FILE__)

require 'rspec/rails'

RSpec.configure do |c|
  c.filter_run_excluding :not_jruby => RUBY_PLATFORM == 'java'
end
